Class {
	#name : #GTSimpleMethodsBrowser,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Inspector'
}

{ #category : #building }
GTSimpleMethodsBrowser >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Methods'.
	browser
		row: #classes size: 25;
		row: #methods;
		row: #source.
	browser transmit
		to: #classes;
		andShow: [ :a | 
			self classesIn: a ].
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
		andShow: [ :a | self sourceIn: a ].
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
	^ a dropDownList
		display: [ :object | 
			| all |
			all := OrderedCollection new.
			object class withAllSuperclassesDo: [:each | all add: each ].
			all ];
		selectedIndex: 1;
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
GTSimpleMethodsBrowser >> methodActionsFor: list [
	^ list selection selector isUnary
		ifTrue: [ Array with: self evaluationAction ]
		ifFalse: [ #() ]
]

{ #category : #building }
GTSimpleMethodsBrowser >> methodsIn: a [
	^ a list
		display: [ :object :class | class methods ];
		sorted: [ :method1 :method2 | method1 selector < method2 selector ];
		format: [ :method | method selector ];
		morphicSelectionAct: [ :list :object :class | Smalltalk tools browser fullOnClass: class selector: list selection selector ]
			icon: GLMUIThemeExtraIcons glamorousBrowse
			on: $b
			entitled: 'Browse';
		dynamicActionsOnSelection: [ :list | self methodActionsFor: list ]
]

{ #category : #building }
GTSimpleMethodsBrowser >> sourceIn: a [
	^ a smalltalkCode
		display: [ :method | method getSource ];
		smalltalkClass: [ :method | method methodClass ];
		doItReceiver: [ :method :entity | entity ];
		selectionPopulate: #evaluatedObject
			on: $o
			entitled: 'Do it and open (o)'
			with: [ :text :method :entity | Compiler evaluate: text selectedText for: entity logged: false ]
]
