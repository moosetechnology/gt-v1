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
	- notifications on system change
	- announcments
	- deprecations of GTExampleFInder // cannot be deleted just like that 
	
	NEW
	- lru cache for results (max last 10)
	- debugger runtime end with #success if debugger is proceeded (bad!)
	- better exception handling for running examples / ugly
	- tests for class and instance side examples
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

{ #category : #todos }
GTExampleTODOs >> spotterIntegration [
	<todo>
	"
	FIX / OLD MODEL
	- diveinto subjects <-> examples
	- diveinto dependencies | dependents
	- diveinto source <-> examples
	"
	
]
