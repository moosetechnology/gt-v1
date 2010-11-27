"
self openOn: Smalltalk organization.
"
Class {
	#name : #GTClassicBrowser,
	#superclass : #GLMGlobalBrowserTemplate,
	#classInstVars : [
		'announcer'
	],
	#category : #'GT-Tools'
}

{ #category : #building }
GTClassicBrowser >> browserActionsIn: b [
	"just for test"
	b act: [ 
		(b pane port: #classCategoryToSelect) value: (Smalltalk organization categoriesMatching: 'RPackage*') first ] entitled: 'Find'.

]

{ #category : #building }
GTClassicBrowser >> buildBrowser [
	browser := GLMTabulator new.
	self browserActionsIn: browser.
	browser
		row: [:row | row column: #classCats; column: #classes; column: #categories; column: #methods ];
		row: #sourceCode.
	browser transmit to: #classCats; andShow: [ :a | self classCategoriesIn: a ].
	browser transmit to: #classes; from: #classCats; andShow: [ :a | self classesIn: a ].
	browser transmit to: #categories; from: #classes; andShow: [ :a | self categoriesIn: a ].
	browser transmit to: #methods; from: #classes; from: #categories; andShow: [ :a | self methodsIn: a ].
	browser transmit
		to: #sourceCode;
		from: #classes;
		from: #methods;
		from: #classCats;
		andShow: [ :a | self sourceCodeIn: a ].
	browser transmit
		fromOutside: #classCategoryToSelect;
		to: #classCats port: #selection.
	browser transmit 
		fromOutside: #classesToSelect;
		to: #classes.
	browser transmit 
		fromOutside: #methodsToSelect;
		to: #methods.
	^ browser
]

{ #category : #building }
GTClassicBrowser >> categoriesIn: a [
	^ (a list)
		allowsDeselection;
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer;
		display: [ :class | class organization categories ]
]

{ #category : #building }
GTClassicBrowser >> classCategoriesIn: a [
	^ (a list)
		display: [ :organization | organization categories asSortedCollection: [ :x :y | x < y ] ];
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer
]

{ #category : #building }
GTClassicBrowser >> classesHierarchyIn: a [
	(a mondrian)
		painting: [ :view :package | 
					view nodes: ((Smalltalk organization listAtCategoryNamed: package) collect: [ :name | Smalltalk classNamed: name ]).
					view edgesFrom: #superclass.
					view treeLayout ];
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer;
		title: 'Hierarchy'
]

{ #category : #building }
GTClassicBrowser >> classesIn: a [
	self classesListIn: a.
	self classesHierarchyIn: a
]

{ #category : #building }
GTClassicBrowser >> classesListIn: a [
	(a tree)
		shouldValidate: true;
		display: [ :classCat | (Smalltalk organization listAtCategoryNamed: classCat) collect: [ :className | Smalltalk classNamed: className ] ];
		children: [ :each | each traitComposition traits ];
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer;
		title: 'Class list'
]

{ #category : #building }
GTClassicBrowser >> methodsIn: a [
	(a list)
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer;
		display: [ :class :category | (class organization listAtCategoryNamed: category) asSortedCollection ].
	^ (a list)
		useExplicitNotNil;
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer;
		when: [ :class :category | class notNil and: [ category isNil ] ];
		display: [ :class :category | class selectors asSortedCollection ]
]

{ #category : #building }
GTClassicBrowser >> sourceCodeIn: a [
	| lintBrowser |
	(a text)
		title: 'Method source';
		display: [ :class :method | class sourceCodeAt: method ];
		forSmalltalk: [ :class | class ].
	(a text)
		forSmalltalk;
		useExplicitNotNil;
		title: 'Class definition';
		display: [ :class | class definition ];
		when: [ :class | class notNil ].
	(a text)
		title: 'Class comment';
		display: [ :class | class comment ];
		useExplicitNotNil;
		when: [ :class | class notNil ].
	lintBrowser := GTLintBrowser new browser.
	lintBrowser
		allowNil;
		when: [ :clas :mth | clas notNil ].
	a custom: lintBrowser
]
