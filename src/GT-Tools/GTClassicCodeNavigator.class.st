"
self openOn: Smalltalk organization .
"
Class {
	#name : #GTClassicCodeNavigator,
	#superclass : #GLMGlobalBrowserTemplate,
	#category : #'GT-Tools'
}

{ #category : #building }
GTClassicCodeNavigator >> buildBrowser [
	browser := GLMTabulator new.
	browser column: #classCats; column: #classes; column: #categories; column: #methods.
	(browser transmit) to: #classCats; andShow: [ :a | self classCategoriesIn: a ].
	(browser transmit) to: #classes; from: #classCats; andShow: [ :a | self classesIn: a ].
	(browser transmit) to: #categories; from: #classes; andShow: [ :a | self categoriesIn: a ].
	(browser transmit) to: #methods; from: #classes; from: #categories; andShow: [ :a | self methodsIn: a ].
	browser transmit toOutside: #selectedClassCategory; from: #classCats.
	browser transmit toOutside: #selectedClass; from: #classes.
	browser transmit toOutside: #selectedMethod; from: #methods.
	"for updating selection from lintBrowser"
	"browser 
		sendTo: #methods -> #selection
		fromOutside: #faultyMethod."
	^ browser
]

{ #category : #building }
GTClassicCodeNavigator >> categoriesIn: a [
	^ (a list)
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer;
		display: [ :class | class organization categories ]
]

{ #category : #building }
GTClassicCodeNavigator >> classCategoriesIn: a [
	^ (a list)
		display: [ :organization | organization categories asSortedCollection: [ :x :y | x < y ] ];
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer
]

{ #category : #building }
GTClassicCodeNavigator >> classesIn: a [
	(a tree)
		shouldValidate: true;
		display: [ :classCat | (Smalltalk organization listAtCategoryNamed: classCat) collect: [ :className | Smalltalk classNamed: className ] ];
		children: [ :each | each traitComposition traits ];
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer;
		title: 'Class list'.
	^ (a mondrian)
		painting: [ :view :package | 
					view nodes: ((Smalltalk organization listAtCategoryNamed: package) collect: [ :name | Smalltalk classNamed: name ]).
					view edgesFrom: #superclass.
					view treeLayout ];
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer;
		title: 'Hierarchy'
]

{ #category : #building }
GTClassicCodeNavigator >> methodsIn: a [
	(a list)
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer;
		display: [ :class :category | (class organization listAtCategoryNamed: category) asSortedCollection ].
	^ (a list)
		useExplicitNotNil;
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer;
		when: [ :class :category | class notNil and: [ category isNil ] ];
		display: [ :class :category | class selectors asSortedCollection ]
]
