"
self open
"
Class {
	#name : #GTCoder,
	#superclass : #GLMGlobalBrowserTemplate,
	#category : #'GT-Coder'
}

{ #category : #building }
GTCoder >> buildBrowser [ 
	browser := GLMTabulator new.
	browser
		column: #packages;
		column: #classes;
		column: #details span: 3.
	self defineActions.
	browser transmit to: #packages; andShow: [:a | self packagesIn: a].
	browser transmit from: #packages; to: #classes; andShow: [:a | self classesIn: a].
	browser transmit 
		passivelyFrom: #packages; 
		from: #classes; 
		to: #details; 
		when: [:package :class | class notNil ]; 
		andShowIfNone: [:a | self detailsIn: a ].
	browser transmit fromOutsidePort: #packageToSelect; to: #packages port: #selection.
	browser transmit fromOutsidePort: #classToSelect; to: #classes port: #selection.
	browser transmit 
		toOutsidePort: #packageToSelect; 
		from: #details port: #methodToSelect;
		transformed: [:method | method methodClass package].
	browser transmit 
		toOutsidePort: #classToSelect; 
		from: #details port: #methodToSelect;
		transformed: [:method | method methodClass].
	^ browser
]

{ #category : #private }
GTCoder >> classesIn: a [ 
	a list
		title: 'Classes';
		display: [ :package | package classes ];
		sorted: [:c1 :c2 | c1 name < c2 name];
"		icon: [ :each | 
			each theNonMetaClass browserIcon isNil 
				ifFalse: [ OBMorphicIcons iconNamed: each theNonMetaClass browserIcon ]
				ifTrue: [ nil ] ];"
		format: [ :each :package |
			(package extendsClass: each)
				ifTrue: [Text string: each name asString attribute: TextColor gray]
				ifFalse: [each name asString] ];
		selectionAct: [:list | list selection inspect] on: $/ entitled: 'Inspect';
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer
]

{ #category : #private }
GTCoder >> defineActions [
	browser morphicAct: [:b |
		| selectedClass composite single |
		composite := GLMSpotterRequest new.
		single := GLMSingleSpotterRequest new
			prompt: 'Find Class';
			searchBlock: [ :string | 
				(self class environment classNames
					select: [ :each | 
						GLMSingleSpotterRequest substring: string matches: each name caseSensitive: false ])
					asSortedCollection collect: [ :each | self class environment at: each ]
				 ];
			labelBlock: [ :class | class name ]
"			iconBlock: [ :class | class browserIcon ];".
		selectedClass := composite add: single; signal.
		selectedClass notNil ifTrue: [
			(b pane port: #packageToSelect) value: selectedClass package.
			(b pane port: #classToSelect) value: selectedClass ].
	] on: $/ icon: GLMUIThemeExtraIcons glamorousSearch entitled: 'Search class'

]

{ #category : #private }
GTCoder >> detailsIn: a [
	| accumulator |
	accumulator := GLMAccumulator new.
	accumulator show: [ :another | 
		another title: [ :package :class | class name ].
		self methodsIn: another ].
	a custom: accumulator
]

{ #category : #building }
GTCoder >> entity [
	^ RPackageOrganizer default
]

{ #category : #private }
GTCoder >> implementorsIn: a [
	a list
		title: 'Implementors';
		display: [ :method | (self systemNavigation allImplementorsOf: method selector) ];
		selectionPopulate: #focusOnMethod
			on: $f
			entitled: 'Jump there'
			with: [ :list | list selection ];
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer 
]

{ #category : #private }
GTCoder >> methodSourceIn: another [
	(another text)
		title: 'Source';
		display: [ :method | method getSource ];
		forSmalltalk: [ :method | method methodClass ]
]

{ #category : #private }
GTCoder >> methodsIn: a [
	| expander |
	expander := GLMExpander new.
	expander display: [ :package :class | class methods ].
	expander
		show: [ :another | 
			another title: [ :method | method selector ].
			self methodSourceIn: another ].
	a custom: expander
]

{ #category : #private }
GTCoder >> packagesIn: a [ 
	a list 
		title: 'Packages';
		display: [ :organizer | organizer packages asSortedCollection: [:x :y | x name < y name ] ];
		format: [:each | each name]
]

{ #category : #private }
GTCoder >> sendersIn: a [
	a list
		title: 'Senders';
		display: [ :method | self systemNavigation allSendersOf: method selector];
		selectionPopulate: #focusOnMethod
			on: $j
			entitled: 'Jump there'
			with: [ :list | list selection ];
		updateOn: SystemAnnouncement from: SystemAnnouncer announcer
]
