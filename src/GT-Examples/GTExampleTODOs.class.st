Class {
	#name : #GTExampleTODOs,
	#superclass : #Object,
	#category : #'GT-Examples-TODO'
}

{ #category : #todos }
GTExampleTODOs >> coreModel [
	<todo>
	"
	- GTExampleOrganizer #atClass:, ... <-> lazy generate if not present
	- notifications on system change
	- announcments
	- deprecations of GTExampleFInder // cannot be deleted just like that 
	- lru cache for results (max last 10)
	- debugger runtime end with #success if debugger is proceeded (bad!)
	"
	
]

{ #category : #todos }
GTExampleTODOs >> inspectorIntegration [
	<todo>
	"
	- graph painter (currently broken <-> still expects proxy)
		- clickable boxes
		- browse inspector by clicking boxes
		- better hover info
	- result visualisation
	"
	
]

{ #category : #todos }
GTExampleTODOs >> spotterIntegration [
	<todo>
	"
	- diveinto subjects <-> examples
	- diveinto dependencies | dependents
	- diveinto source <-> examples
	"
	
]
