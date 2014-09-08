Class {
	#name : #GTPillarParserTest,
	#superclass : #PPCompositeParserTest,
	#category : #'GT-InspectorExtensions-Pillar'
}

{ #category : #'as yet unclassified' }
GTPillarParserTest >> parserClass [
	^ GTPillarParser
]

{ #category : #'as yet unclassified' }
GTPillarParserTest >> source1 [
	^ '
!Concurrent Programming in Pharo

Let us start with a simple example. We will explain all the details in subsequent sections. The following code creates two processes using the message ==fork== sent to a block. In each process we enumerate numbers. During each loop step, using the expression ==Processor yield==, the current process stop its execution to give a chance to other processes with the same priority to get executed. At the end of the loop we refresh the ==Transcript==.

[[[
[	1 to: 10 do: 
    [:i | Transcript nextPutAll: i  printString, '' ''. Processor yield].
Transcript endEntry.] fork.

[	101 to: 110 do: 
[:i |  Transcript nextPutAll: i  printString, '' ''.  Processor yield]. 
Transcript endEntry.] fork
]]]

Figure *TwoInterleavingProcesses* shows the output produced by the execution of the snippet.

+Two interleaving processes.>file://figures/TwoInterleavedProcesses.pdf|width=50|label=TwoInterleavingProcesses+ 

+file://figures/TwoInterleavedProcesses.pdf+ 	
	'
]

{ #category : #'as yet unclassified' }
GTPillarParserTest >> testCode [
	self parse: '[[[
		Transcript crShow: ''Hi there!''
	]]]' rule: #code.

	self assert: result = #code.
]

{ #category : #'as yet unclassified' }
GTPillarParserTest >> testCode2 [
	self parse: '[[[
[	1 to: 10 do: 
    [:i | Transcript nextPutAll: i  printString, '' ''. Processor yield].
Transcript endEntry.] fork.

[	101 to: 110 do: 
[:i |  Transcript nextPutAll: i  printString, '' ''.  Processor yield]. 
Transcript endEntry.] fork
]]]' rule: #code.
]

{ #category : #'as yet unclassified' }
GTPillarParserTest >> testCode3 [
	self parse: '[[[
		Transcript crShow: ''Hi there!'']]]' rule: #code.

	self assert: result = #code.
]

{ #category : #'as yet unclassified' }
GTPillarParserTest >> testCode4 [
	self parse: '[[[
	AClass>>aMethod
		Transcript crShow: ''Hi there!''
	]]]' rule: #code.

	self assert: result = #code.
]

{ #category : #'as yet unclassified' }
GTPillarParserTest >> testCode5 [
	self parse: '[[[
	AClass class>>aMethod
		Transcript crShow: ''Hi there!''
	]]]' rule: #code.

	self assert: result = #code.
]

{ #category : #'as yet unclassified' }
GTPillarParserTest >> testCodeIsland [
	self parse: '[[[
		Transcript crShow: ''Hi there!''
	]]]' rule: #code.

	self assert: result = #code.
]

{ #category : #'as yet unclassified' }
GTPillarParserTest >> testFile [
	self parse: self source1.

	self assert: result size = 3.
	self assert: result first = #code.
	self assert: result second = #link.
	self assert: result third = #link.
]

{ #category : #'as yet unclassified' }
GTPillarParserTest >> testLink [
	self parse: '+file://whatever+' rule: #link.
	
	self assert: result = #link.
]

{ #category : #'as yet unclassified' }
GTPillarParserTest >> testLink2 [
	self parse: '+Two interleaving processes.>file://figures/TwoInterleavedProcesses.pdf|width=50|label=TwoInterleavingProcesses+' rule: #link.
]

{ #category : #'as yet unclassified' }
GTPillarParserTest >> testLink3 [
	self parse: '+file://figures/TwoInterleavedProcesses.pdf+' rule: #link.
]

{ #category : #'as yet unclassified' }
GTPillarParserTest >> testLinkIsland [
	self parse: '+file://whatever+' rule: #link.
	
	self assert: result = #link.
]
