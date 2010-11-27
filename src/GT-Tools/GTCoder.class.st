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
	browser column: #packages; column: #classes; column: #categoriesAndMethods span: 2.
	browser transmit 
		to: #packages; 
		andShow: [ :a | self packagesIn: a ].
	browser transmit 
		to: #classes; 
		from: #packages; 
		andShow: [ :a | self classesIn: a ].
	browser transmit
		to: #categoriesAndMethods;
		from: #packages;
		from: #classes;
		when: [:package :class | class notNil];
		andShowIfNone: [:a | 
			a custom: (GTCoderCategoriesMethods new browser
				title: 'Instance';
				display: [:package :class | Array with: package with: class]).
			a custom: (GTCoderCategoriesMethods new browser
				title: 'Meta';
				display: [:package :class | Array with: package with: class theMetaClass]) ].
	^ browser
]

{ #category : #others }
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
GTCoder >> packagesIn: a [ 
	a list 
		title: 'Packages';
		display: [ :organizer | organizer packages asSortedCollection: [:x :y | x name < y name ] ];
		format: [:each | each name]
]
