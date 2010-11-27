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
"	browser transmit
		to: #classes port: #metaClassSelection;
		from: #classes;
		transformed: [:class | class theMetaClass].
	browser transmit 
		to: #categories;
		from: #classes;
		andShow: [ :a | self categoriesIn: a ].
	browser transmit 
		to: #methods; 
		from: #packages; 
		from: #classes;
		from: #categories; 
		andShow: [ :a | self methodsIn: a ]."
	^ browser
]

{ #category : #building }
GTCoder >> categoriesIn: a [
	a list
		allowsDeselection;
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer;
		display: [ :class | class organization categories ]
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
GTCoder >> instanceMethodsIn: a [ 
	a list
		title: 'Instance';
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer;
		display: [ :package :class :category | 
			(class methodDict values select: [:each | each category = category]) asSortedCollection: [:x :y | x selector < y selector ] ];
		format: [:each :package :class |
			((each isDefinedInPackage: package) or: [each isExtensionInPackage: package])
				ifTrue: [each selector asString]
				ifFalse: [Text string: each selector asString attribute: TextColor gray] ].
	a list
		title: 'Instance';
		useExplicitNotNil;
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer;
		when: [ :package :class :category | class notNil and: [ category isNil ] ];
		display: [ :package :class :category | 
			class methodDict values asSortedCollection: [:x :y | x selector < y selector ] ];
		selectionAct: [:list :package :class | 
			(Array with: package with: class with: list selection) inspect  ] on: $/ entitled: 'Inspect';
		format: [:each :package :class |
			((each isDefinedInPackage: package) or: [each isExtensionInPackage: package])
				ifTrue: [each selector asString]
				ifFalse: [Text string: each selector asString attribute: TextColor gray] ].

]

{ #category : #building }
GTCoder >> methodsIn: a [ 
	self instanceMethodsIn: a.
	
]

{ #category : #building }
GTCoder >> packagesIn: a [ 
	a list 
		title: 'Packages';
		display: [ :organizer | organizer packages asSortedCollection: [:x :y | x name < y name ] ];
		format: [:each | each name]
]
