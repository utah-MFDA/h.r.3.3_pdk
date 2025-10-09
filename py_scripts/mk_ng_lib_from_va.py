import os
import re

module_re = r'module\s+(\w+)\(((?:\w+\s*,\s*)*\s*\w+)\)\s*;'
# within_module_re = r'module([\S\s]*?)endmodule'
within_modele_re = r'module\s+(\w+)([\S\s]*?)endmodule'
parameter_re = r'(\(\*(?:\s*\w+\=\"[^\n\"]+\"\s*,?)+\*\))\s+parameter\s+(?:real)\s+(\w+)\s*\=\s*([\w\.]+)\s*;'


def mk_ng_lib_from_va(va_file, only_if_module_is_file=True):

    if va_file.split('.')[-1] != 'va':
        raise ValueError(
            f"Cannot parser {va_file} incorrect extension or format")

    va_file_basename = os.path.basename(va_file)
    va_file_module_basename = va_file_basename.replace('.va', '')
    lib_file = va_file.replace('.va', '.lib')

    with open(va_file, 'r') as va_read:
        va_signatures = re.findall(module_re, va_read.read())

    if len(va_signatures) == 0:
        raise Exception(f"No modules found in {va_file}")

    with open(va_file, 'r') as va_read:
        module_body = re.findall(within_modele_re, va_read.read())
        num_ports = 0

        mod_parameters = ''

        for ind, m_body in enumerate(module_body):
            if only_if_module_is_file and va_file_basename.replace('.va', '') == m_body[0]:
                print(ind)
                num_ports = len(va_signatures[ind][1].split(','))
                mod_parameters = re.findall(parameter_re, m_body[1])
            elif not only_if_module_is_file:
                pass
            else:
                pass

        with open(lib_file, 'w+') as lib_write:
            #lib_write.write(f'{va_file_module_basename}' + '\n')
            lib_write.write('\n')
            lib_write.write('.control\n')
            lib_write.write(
                f'pre_osdi {va_file.replace(".va", ".osdi")}' + '\n')
            lib_write.write('.endc\n')
            lib_write.write('\n')

            lib_write.write(
                f'.model {va_file_module_basename}_model {va_file_module_basename}')
            for p in mod_parameters:
                lib_write.write(f' {p[1]}={p[2]}')
            lib_write.write('\n')

            # -- subckt
            lib_write.write(f'.subckt {va_file_module_basename}_sp ')
            # lib_write.write('{va_file_module_basename}')
            lib_write.write(' '.join(
                [chr(97 + a) for a in range(0, num_ports)]
            ))
            #lib_write.write(' PARAMS:')
            lib_write.write(' params:')
            for p in mod_parameters:
                lib_write.write(f' {p[1]}={p[2]}')
            lib_write.write('\n')

            lib_write.write('N1 ')
            lib_write.write(' '.join(
                [chr(97 + a) for a in range(0, num_ports)]
            ))
            lib_write.write(f' {va_file_module_basename}_model')
            for p in mod_parameters:
                lib_write.write(f' {p[1]}={p[1]}')
            lib_write.write('\n')

            lib_write.write('.ends')

        print("Finished module: ", va_file_basename.replace('.va', ''))


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser()

    parser.add_argument("--va_file", required=True)

    args = parser.parse_args()

    mk_ng_lib_from_va(
        args.va_file
    )
