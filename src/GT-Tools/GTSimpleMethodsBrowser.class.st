Class {
	#name : #GTSimpleMethodsBrowser,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools'
}

{ #category : #building }
GTSimpleMethodsBrowser >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Methods'.
	browser
		row: #methods;
		row: #source.
	browser transmit
		to: #methods;
		andShow: [ :a | 
					a list
						display: [ :object | object class methods ];
						format: [ :method | method selector ];
						dynamicActionsOnSelection: [ :list | self methodActionsFor: list ] ].
	browser transmit
		to: #source;
		from: #methods;
		andShow: [ :a | 
					a text
						display: [ :method | method getSource ];
						forSmalltalk: [ :method | method methodClass ] ].
	browser transmit
		toOutside: #selection;
		from: #methods port: #evaluatedObject.
	^ browser
]

{ #category : #building }
GTSimpleMethodsBrowser >> evaluationAction [
	^ GLMGenericAction new
		action: [ :listPresentation :obj | 
					| result |
					result := obj perform: listPresentation selection selector.
					(listPresentation pane port: #evaluatedObject) value: result ];
		shortcut: $o;
		title: 'Evaluate and open';
		yourself
]

{ #category : #building }
GTSimpleMethodsBrowser >> methodActionsFor: list [
	^ list selection selector isUnary
		ifTrue: [ Array with: self evaluationAction ]
		ifFalse: [ #() ]
]
