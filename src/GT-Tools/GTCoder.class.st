"
self open
"
Class {
	#name : #GTCoder,
	#superclass : #GTAbstractCoder,
	#category : #'GT-Tools-Coder'
}

{ #category : #building }
GTCoder >> buildBrowser [ 
	browser := GLMTabulator new.
	browser
		column: #packages;
		column: #classes;
		column: #methods span: 3.
	self defineActions.
	browser transmit to: #packages; andShow: [:a | self packagesIn: a].
	browser transmit from: #packages; to: #classes; andShow: [:a | self classesIn: a].
	browser transmit from: #packages; from: #classes; to: #methods; andShow: [:a | self methodsIn: a ].
	browser transmit fromOutside: #packageToSelect; to: #packages port: #selection.
	browser transmit fromOutside: #classToSelect; to: #classes port: #selection.
	^ browser
]

{ #category : #building }
GTCoder >> defineActions [
	browser act: [:b |
		| selectedClass |
		selectedClass := OBCompletionRequest new
			prompt: 'Find Class';
			searchBlock: [ :string | OBCmdFindClass new findClassIn: Smalltalk pattern: string ];
			labelBlock: [ :class | class name ];
			iconBlock: [ :class | class browserIcon ];
			signal.
		selectedClass notNil ifTrue: [
			(b pane port: #packageToSelect) value: selectedClass package.
			(b pane port: #classToSelect) value: selectedClass ].
	] icon: MooseIcons mooseSearch entitled: 'Search class'.

]

{ #category : #building }
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

{ #category : #building }
GTCoder >> methodsIn: a [
	| expander |
	expander := GLMExpander new.
	expander title: 'Methods'.
	expander display: [ :package :class | class methods ].
	expander show: [ :another | 
		another title: [ :method | method selector ].
		another text 
			display: [ :method | method getSource ].
		self sendersIn: another.
		self implementorsIn: another ].
	a custom: expander
]

{ #category : #building }
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
