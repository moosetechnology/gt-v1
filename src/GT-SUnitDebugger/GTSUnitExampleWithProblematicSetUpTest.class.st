Class {
	#name : #GTSUnitExampleWithProblematicSetUpTest,
	#superclass : #TestCase,
	#category : #'GT-SUnitDebugger'
}

{ #category : #setup }
GTSUnitExampleWithProblematicSetUpTest >> setUp [
	42 messageThatIsNotUnderstood
]

{ #category : #testing }
GTSUnitExampleWithProblematicSetUpTest >> testWithErrorInSetup [
	self assert: true
]
