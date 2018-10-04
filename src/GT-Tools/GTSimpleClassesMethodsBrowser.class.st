"
This is a simple browser showing a list of classes and their methods. It is meant to be used inside other browsers.

self openOn: Collection withAllSubclasses
"
Class {
	#name : #GTSimpleClassesMethodsBrowser,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools-Utils'
}

{ #category : #building }
GTSimpleClassesMethodsBrowser >> buildBrowser [
	browser := GLMTabulator new.
	browser column: #classes; column: #methods.
	browser transmit to: #classes; andShow: [ :a |
		a list
			display: [:classes | classes ];
			sorted: [:x :y | x name < y name]].
	browser transmit to: #methods; from: #classes; andShow: [ :a |
		a list
			display: [:class | class selectors];
			sorted].
	browser transmit toOutsidePort: #selectedClass; from: #classes.
	browser transmit toOutsidePort: #selectedMethod; from: #methods.
	^ browser
]
