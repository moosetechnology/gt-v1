"
This browser is used to browse the class structure of every object in the inspector.

self openOn: World
"
Class {
	#name : #GTSimpleMethodsBrowser,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Inspector'
}

{ #category : #building }
GTSimpleMethodsBrowser >> accumulatedSourceOf: m for: object in: composite [
	composite accumulator with: [ :acc | 
		acc show: [ :a |
			a title: [ :method | method selector ].
			self sourceOf: m for: object in: a ] ]
]

{ #category : #building }
GTSimpleMethodsBrowser >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Methods'.
	browser
		row: [ :r | r column: #classes; column: #methods span: 3 ];
		row: #source.
	browser transmit
		to: #classes;
		andShow: [ :a | self classesIn: a ].
	browser transmit
		to: #classes port: #selection;
		transformed: [:each | each class ].
	browser transmit
		fromOutsidePort: #entity;
		from: #classes;
		to: #methods;
		andShow: [ :a | self methodsIn: a ].
	browser transmit
		from: #methods;
		fromOutsidePort: #entity;
		to: #source;
		when: [ :method | method notNil ];
		andShowIfNone: [ :a :method :object | self accumulatedSourceOf: method for: object in: a ].
	browser transmit
		toOutsidePort: #selection;
		from: #methods port: #evaluatedObject.
	browser transmit
		toOutsidePort: #selection;
		from: #source port: #evaluatedObject.
	^ browser
]

{ #category : #building }
GTSimpleMethodsBrowser >> classesIn: a [
	^ a list
		display: [ :object | 
			| all |
			all := OrderedCollection new.
			object class withAllSuperclassesDo: [:each | all add: each ].
			all ];
"		selectedIndex: 1;"
		format: [ :class | class name ];
		morphicSelectionAct: [ :list :object | Smalltalk tools browser fullOnClass: object class selector: list selection selector ]
			icon: GLMUIThemeExtraIcons glamorousBrowse
			on: $b
			entitled: 'Browse'
]

{ #category : #building }
GTSimpleMethodsBrowser >> evaluationAction [
	^ GLMGenericAction new
		action: [ :listPresentation :obj | 
					| result |
					result := obj perform: listPresentation selection selector.
					(listPresentation pane port: #evaluatedObject) value: result ];
		shortcut: $o;
		title: 'Do it and open';
		yourself
]

{ #category : #building }
GTSimpleMethodsBrowser >> methodActionsFor: aMethod [
	^ aMethod selector isUnary
		ifTrue: [ Array with: self evaluationAction ]
		ifFalse: [ #() ]
]

{ #category : #building }
GTSimpleMethodsBrowser >> methodsIn: a [
	^ a list
		display: [ :object :class | class methods ];
		tags: [ :method | method category ];
		sorted: [ :method1 :method2 | method1 selector < method2 selector ];
		format: [ :method | method selector ];
		morphicSelectionAct: [ :list :object :class | 
			Smalltalk tools browser 
				fullOnClass: class 
				selector: list selection selector ]
			icon: GLMUIThemeExtraIcons glamorousBrowse
			on: $b
			entitled: 'Browse';
		dynamicActionsOnSelection: [ :list | self methodActionsFor: list selection ]
]

{ #category : #building }
GTSimpleMethodsBrowser >> sourceOf: method for: object in: composite [
	^ composite smalltalkCode
		display: [ :m | m getSource ];
		smalltalkClass: [ :m | m methodClass ];
		doItReceiver: [ object ];
		selectionPopulate: #evaluatedObject
			on: $o
			entitled: 'Do it and open (o)'
			with: [ :text | Compiler evaluate: text selectedText for: object logged: false ];
		act: [:text :m | 
				| newMethod |
				newMethod := method methodClass compile: text text notifying: nil. 
				text pane browser pane update.
				self flag: 'This is a hack because it accesses the state of another browser directly.
				It should be solved through transmissions'.
				((text pane browser paneNamed: #methods) port: #selection) 
					value: (method methodClass methodNamed: newMethod).
				 ] 
			icon: GLMUIThemeExtraIcons glamorousAccept 
			on: $s
			entitled: 'Accept'
]
