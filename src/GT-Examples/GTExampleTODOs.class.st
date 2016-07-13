Class {
	#name : #GTExampleTODOs,
	#superclass : #Object,
	#category : #'GT-Examples-TODO'
}

{ #category : #todos }
GTExampleTODOs >> coreModel [
	<todo>
	"
	FIX / OLD MODEL
	- GTExampleOrganizer #atClass:, ... <-> lazy generate if not present
		--> invert lookup !
	- deprecations of GTExampleFInder // cannot be deleted just like that 
	
	NEW
	- debugger runtime end with #success if debugger is proceeded (bad!)
	- better exception handling for running examples / ugly
	- debugger does not stop at exception !
	"
	
]
