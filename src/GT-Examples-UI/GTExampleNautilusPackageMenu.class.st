Class {
	#name : #GTExampleNautilusPackageMenu,
	#superclass : #GTAbstractExampleMenu,
	#category : #'GT-Examples-UI'
}

{ #category : #menus }
GTExampleNautilusPackageMenu class >> menuFor: aBuilder [
	<contextMenu>
	<nautilusGlobalPackageMenu>
	^ self new
		menuFor: aBuilder
		yourself
]

{ #category : #public }
GTExampleNautilusPackageMenu >> menuFor: aBuilder [
	| model node package |
	(model := aBuilder model) ifNil: [ ^ self ].
	(node := model selectedPackage) ifNil: [ ^ self ].
	(package := node item) ifNil: [ ^ self ].
	
	self buildSubmenu: aBuilder.
	self inspectExamples: [ package gtExamplesContained ] builder: aBuilder.
	self inspectReturnValue: [ package gtExamplesContained ] builder: aBuilder.
	self inspectProblems: [ package gtExamplesContained ] builder: aBuilder.
	self buildSeparator.
	self runExamples: [ package gtExamplesContained ] builder: aBuilder.
	self debugExamples: [ package gtExamplesContained ] builder: aBuilder.
]

{ #category : #private }
GTExampleNautilusPackageMenu >> submenuOrder [
	^ 1010
]
