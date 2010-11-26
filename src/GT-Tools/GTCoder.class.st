"
self openOn: RPackageOrganizer default

"
Class {
	#name : #GTCoder,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools'
}

{ #category : #building }
GTCoder >> buildBrowser [
	"self openOn: RPackageOrganizer default"
	browser := GLMTabulator new.
	browser column: #packages; column: #classes; column: #methods.
	browser transmit to: #packages; andShow: [ :a | self packagesIn: a ].
	browser transmit to: #classes; from: #packages; andShow: [ :a | self classesIn: a ].
	browser transmit to: #methods; from: #packages; from: #classes; andShow: [ :a | self methodsIn: a ].
	^ browser
]

{ #category : #'as yet unclassified' }
GTCoder >> classPointOfViewBrowser [
	"self new classPointOfViewBrowser openOn: RPackageOrganizer default"
	browser := GLMTabulator new.
	browser column: #packages; column: #classes; column: #definingPackages; column: #methods.
	browser transmit to: #packages; andShow: [ :a |
		a list 
			display: [ :organizer | organizer packages asSortedCollection: [ :x :y | x name < y name ] ];
			format: #name ].
	browser transmit to: #classes; from: #packages; andShow: [ :a | 
		a list
			display: [ :package | package classes ];
			format: [ :each :package |
				(package extendsClass: each)
					ifTrue: [Text string: each name asString attribute: TextColor gray]
					ifFalse: [each name asString] ];
			selectionAct: [:list | list selection inspect] on: $/ entitled: 'Inspect' ].
	browser transmit to: #definingPackages; from: #classes; andShow: [ :a | 
		a list 
			display: [ :class | class packages];
			format: #name ].
	browser transmit to: #methods; from: #definingPackages; from: #classes; andShow: [ :a | 
		a list 
			title: 'Instance';
			display: [ :package :class | package selectorsForClass: class ];
			selectionAct: [:list :package :class | (Array with: package with: class with: list selection) inspect  ] on: $/ entitled: 'Inspect';
			format: [:each :package :class |
				(package includesSelector: each ofClass: class) 
					ifFalse: [Text string: each asString attribute: TextColor gray]
					ifTrue: [each asString] ].
		a list 
			title: 'Meta';
			display: [ :package :class | class theMetaClass selectors ];
			format: [:each :package :class |
				(package includesSelector: each ofClass: class class) 
					ifFalse: [Text string: each asString attribute: TextColor gray]
					ifTrue: [each asString] ] ].
	^ browser
]

{ #category : #building }
GTCoder >> classesIn: a [ 
	a list
		title: 'Classes';
		display: [ :package | package classes ];
		format: [ :each :package |
			(package extendsClass: each)
				ifTrue: [Text string: each name asString attribute: TextColor gray]
				ifFalse: [each name asString] ];
		selectionAct: [:list | list selection inspect] on: $/ entitled: 'Inspect'
]

{ #category : #building }
GTCoder >> methodsIn: a [ 
	a list 
		title: 'Instance';
		display: [ :package :class | class methodDict values ];
		selectionAct: [:list :package :clas | 
			(Array with: package with: clas with: list selection) inspect  ] on: $/ entitled: 'Inspect';
		format: [:each :package :class |
			((each isDefinedInPackage: package) or: [each isExtensionInPackage: package])
				ifTrue: [each selector asString]
				ifFalse: [Text string: each selector asString attribute: TextColor gray] ].
	a list 
		title: 'Meta';
		display: [ :package :class | class theMetaClass methodDict values ];
		selectionAct: [:list :package :clas | 
			(Array with: package with: clas with: list selection) inspect  ] on: $/ entitled: 'Inspect';
		format: [:each :package :class |
			((each isDefinedInPackage: package) or: [each isExtensionInPackage: package]) 
				ifTrue: [each selector asString]
				ifFalse: [Text string: each selector asString attribute: TextColor gray] ]
]

{ #category : #building }
GTCoder >> packagesIn: a [ 
	a list 
		title: 'Packages';
		display: [ :organizer | organizer packages asSortedCollection: [:x :y | x name < y name ] ];
		format: [:each | each name]
]
