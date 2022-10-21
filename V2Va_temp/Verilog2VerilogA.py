
#import numpy as np
import sys
import pandas as pd
import re

"""
input arguments

input file, or -i; input file can be v or vmf
output file, or -o; the output file is .va if no argument is given
length file, or -l; assumed name with .xlsx or csv
library file, or -lib; this can be written into the vmf file
template file, or -mfsp; this adds additional start and ending file information
"""

def Verilog2VerilogA(inputVerilogFile, outputVerilogFile=None):


    inputVerilogFile = inputVerilogFile.replace('\\', '/')
    # input file declaration
    #inFile_Verilog = "smart_toilet.v"
    inFile_Verilog = inputVerilogFile
    #inFile_lengths = "smart_toilet_lengths.xlsx"
    inFile_lengths = inputVerilogFile[:-2] + "_lengths.xlsx"
    #print(inFile_lengths)

    library_csv =    "StandardCellLibrary.csv"
    solnFile       = "solutionFile.csv"

    # output file declaration
    if outputVerilogFile == None:
        outFile_sp     = inFile_Verilog[:-2] + '.sp'

    # files for start and ending expressions
    initExpress    = "initExpression_V2VA"
    endExpress     = "endExpression_V2VA"

    outfile_VA = inFile_Verilog[:-1] + 'va'

    # local library location for testing

    libraryPath = "~/Github/component_library/VerilogA/Elibrary/standardCells/"
    libraryPath2= "~/Github/component_library/VerilogA/Elibrary/"

    # open files

    Vfile = open(inFile_Verilog)
    SPfile= open(outFile_sp, '+w')
    iExp  = open(initExpress)
    eExp  = open(endExpress)

    # Load standard cell library

    library = pd.read_csv(library_csv)
    wireLenDF = pd.read_excel(inFile_lengths)

    # load solution concentrations
    solnDF = pd.read_csv(solnFile)

    # used to keep track of appending to run sim file
    numSoln = 0

    for soln in solnDF.iterrows():
        Vfile = open(inFile_Verilog)
        iExp  = open(initExpress)
        eExp  = open(endExpress)

        SP_outputFile_name = inFile_Verilog[:-2] + '_' + soln[1].loc['inlet'] + '.sp'

        SPfile = open(SP_outputFile_name, '+w')
        
        SPfile.write(''.join(iExp.readlines()))

        createSpiceRunScript(SP_outputFile_name[:-3], numSoln)
        numSoln += 1

        # import library files
        for rowN, row in enumerate(library.iterrows()):
            #if rowN == 0:
            #    continue
            rStr = row[1]['Standard_Cell']
            libStr = '.hdl ' + libraryPath + 'E' + rStr + '.va\n'
            SPfile.write(libStr)

        SPfile.write('\n')

        SPfile.write('*hard coded EChannel, used for wires\n' + '.hdl ' + libraryPath2 + "EChannel.va\n")
        SPfile.write('*hard coded Pressure Pump, used for wires\n' + '.hdl ' + libraryPath2 + "EPrPump.va\n\n\n")

        numberOfComponents = 0
        currentLine = ''
        # wire list used to keep track of number of connections
        wireList    = {}
        inputList   = []
        outputWords = []
        outNum      = 0
        probeList   = {}



        # get line
        for line_num, line in enumerate(Vfile):

            if len(line) > 0 and not(line == '\n'):
                if not line.rstrip()[-1] == ';':
                    # append to current line
                    # remove comments
                    if '//' in line:
                        line = line.split('//')[0]
                    currentLine += line
                    continue
                else:
                    # pass to parser
                    currentLine += line
                    line = currentLine
            else:
                continue

            # remove inital whitespace
            line = line.lstrip(' ').replace(';', '').replace('\n', '')
            vars = line.split(' ')[0]
        
            VA_line_str = ''


            if vars == 'input':

                # create pump devices
                # we will assume pressure pumping devices
                params = line.replace('input ', '').replace(' ', '').split(',')
                for p in params:
                    VA_line_str += 'X' + str(numberOfComponents) + ' ' + str(p) + '_0 ' + str(p) + '_0c PressurePump pressure=100k '
                    if str(p) == soln[1].loc['inlet']:
                        VA_line_str += 'chemConcentration=' + str(soln[1].loc['solutionC']) + ' '
                    VA_line_str += '\n'
                    numberOfComponents += 1

                    

                # build init lines for inputs
                for p in params:
                    VA_line_str += 'X' + str(numberOfComponents) + ' ' + str(p) + '_0 ' + str(p) + '_1  ' + str(p) + '_0c ' + str(p) + '_1c Channel length='
                    # get wire length fro wire length file
                    row = wireLenDF.loc[wireLenDF['wire'] == p]
                    wireLength = row.iloc[0,1]
                    VA_line_str += str(wireLength) + 'm\n'

                    inputList.append(p)

                    numberOfComponents += 1
                
                VA_line_str += '\n'

            elif vars == 'output':
                outputLine = line.replace('output ', '')
                for out in outputLine.replace(' ', '').split(','):
                    outputWords.append(out)

                    VA_line_str += 'X' + str(numberOfComponents) + ' ' + str(out) + '_ch 0  ' + str(out) + '_chC outc' + str(outNum) + ' Channel length='
                    outNum += 1
                    # add output wire
                    row = wireLenDF.loc[wireLenDF['wire'] == out]
                    wireLength = row.iloc[0,1]
                    VA_line_str += str(wireLength) + 'm\n\n'

                    numberOfComponents += 1

            elif vars == 'module':
                pass
            
            elif vars == 'wire':
                # create channel modules
                wires = line.replace('wire ', '').replace(' ', '').split(',')
                
                #
                init_wire_string = '*Declared wires'
                
                for w in wires:
                    # get length of connection

                    # string
                    VA_line_str += 'X' + str(numberOfComponents) + ' ' + str(w) + '_0 ' + str(w) + '_1 ' + ' ' + str(w) + '_0c ' + str(w) + '_1c  ' + 'Channel length='

                    row = wireLenDF.loc[wireLenDF['wire'] == w]

                    wireLength = row.iloc[0,1]

                    VA_line_str += str(wireLength) + 'm\n'

                    outFile_sp

                    wireList[w] = 0

                    numberOfComponents += 1
                #pass
            elif vars == 'endmodule':
                pass


            # variable is a standard cell
            else:
                #line_var = line.lstrip().split(' ')[0]

                # check if in library
                if (library['Standard_Cell'].eq(vars)).any():
                    standardCell = vars[0]
                
                    ioPara = ''.join(line.replace('  ', ' ').split(' ')[2:])

                    io_expression = False
                    connectionWord= False
                    portPhrase = ''
                    ports      = []

                    for char in ioPara:
                        if not io_expression and not connectionWord and char == '.':
                            io_expression = True
                        elif io_expression and not connectionWord and char == '(':
                            #Start connection word
                            io_expression = False
                            connectionWord = True
                        elif not io_expression and connectionWord and char == ')':
                            #end of port word
                            io_expression = False
                            connectionWord= False
                            ports.append(portPhrase)
                            portPhrase = ''
                        elif not io_expression and connectionWord:
                            portPhrase += char

                    VA_line_str += 'X' + str(numberOfComponents) + ' '
                    VA_line_str_chem = ''

                    for p in ports:
                        if p in wireList.keys():
                            VA_line_str += str(p) + '_' + str(wireList[p]) + ' '
                            VA_line_str_chem += str(p) + '_' + str(wireList[p]) + 'c '
                            wireList[p] += 1
                        else:
                            if p in inputList:
                                VA_line_str += str(p) + '_1 '
                                VA_line_str_chem += str(p) + '_1c '
                            elif p in outputWords:
                                VA_line_str += str(p) + '_ch '
                                VA_line_str_chem += str(p) + '_chC '
                            else:
                                VA_line_str += str(p) + ' '
                                VA_line_str_chem += str(p) + 'c '

                    # probes for mixer
                    #if vars == 'diffmix_25px_0':
                        
                    #    probeList['X'+str(numberOfComponents)]
                        
                    VA_line_str += VA_line_str_chem + vars + '\n'

                    numberOfComponents += 1

                else:
                    print("String: " + vars + " line number: " + str(line_num) + " not in library.")

            # Write line to file
            SPfile.write(VA_line_str)
            # refresh line every pass
            currentLine = ''

        SPfile.write(''.join(eExp.readlines()))

    

def createSpiceRunScript(outputFileName, numSoln):
    # make run spice file

    outputFileName = outputFileName.replace('\\', '/')
    outputPath = ''

    if len(outputFileName.split('/')) > 1:
        fileCharLen = len(outputFileName.split('/')[-1])
        outputPath = outputFileName[:-fileCharLen]
        outputFileName = outputFileName[-fileCharLen:]

    if numSoln == 0:
        simScript = open(outputPath + '/' + "runSims.csh", '+w')
        simScript.write('#/bin/tcsh\n\n')
    else:
        simScript = open(outputPath + '/' + "runSims.csh", 'a')
    
    if outputFileName[:1] == './': 
        rm_start = 2
    else:
        rm_start = 0

    # TODO put replace earlier
    o_soln_name = outputFileName
    mkDirPhrase = "mkdir " + outputPath + o_soln_name + "\n"
    spiceScriptPhrase = "hspice " + outputPath + o_soln_name + ".sp -o "  + outputPath  + o_soln_name + "/" + o_soln_name[rm_start:] + "_o\n\n"
    simScript.write(mkDirPhrase + spiceScriptPhrase)

if __name__ == "__main__":
    #inV = sys.argv[1]
    inV = '.\\testFiles\\smart_toilet_test2\\smart_toilet2.v'

    Verilog2VerilogA(inV)