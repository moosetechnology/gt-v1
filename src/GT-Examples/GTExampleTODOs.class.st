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

{ #category : #todos }
GTExampleTODOs >> packaging [
	<todo>
	"
	GT-Examples-Spotter-Extensions <--- spotter extensions (depends spotter)
	GT-Examples-Inspector-Extensions <--- inspector extensions (depends inspector)
	GT-Examples-Roassal-Extensions <--- roassal extensions + RTExampleFactory (depends roassal2) 
	GT-Examples-Extensions <--- common pharo extensions (depends base pkgs)
	"
	
]
