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
	- Changes
		#gtExamplesSource ---> subjects
		#gtExamplesProvider ---> subjects
		#gtExampleFinder ---> gtExampleFactory
	
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
	GT-Examples (core-model)
	GT-Tests-Examples (tests for core-model)
	GT-Examples-Examples (all pharo-image-examples)
	GT-Examples-Spotter
		+ spotter extensions (depends spotter)
		+ 'ui' / #gtSpotter*
		+ examples specific for spotter
	GT-Examples-Inspector
		+ inspector extensions (depends inspector)
		+ 'ui' / #gtInspector* / #gtDisplayOn*
		+ examples specific for inspector
	GT-Examples-Roassal 
		+ roassal extensions (depends roassal2) 
		+ 'ui' / #gtInspectorRoassal* / GTExampleGraphPainter
	GT-Examples-Pharo 
		+ common pharo extensions (depends base-pkgs in pharo image)
		+ 'ui' / RB / Nautilus / SUnit / Help / ...
	"
	
]
