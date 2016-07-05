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
	- lru cache for results (max last 10)
	- debugger runtime end with #success if debugger is proceeded (bad!)
	- better exception handling for running examples / ugly
	"
	
]

{ #category : #todos }
GTExampleTODOs >> inspectorIntegration [
	<todo>
	"
	FIX / OLD MODEL
	- graph painter (currently broken <-> still expects proxy)
		- clickable boxes
		- browse inspector by clicking boxes
		- better hover info
	
	NEW
	- result visualisation
	"
	
]
