Extension { #name : #GTExampleGroup }

{ #category : #'*GT-Examples-UI' }
GTExampleGroup >> gtInspectorExamplesIn: composite [
	<gtInspectorPresentationOrder: 1>
	| examplesWithResults |
	examplesWithResults := self examples collect: [ :each | GTExampleWithResult new example: each ].
	composite fastTable
		title: 'Examples';
		display: [ examplesWithResults ];
		icon: [ :each | each icon ];
		column: 'Name' evaluated: [ :each | each gtDisplayString ];
		column: 'Selector' evaluated: [ :each | each example selector ];
		column: 'Class' evaluated: [ :each | each example methodClass instanceSide name ];
		selectionAct: [ :list | list rawSelection run . list update . list selection: list rawSelection result returnValue ] on: $r command entitled: 'Run';
		selectionAct: [ :list | list rawSelection debug . list update ] entitled: 'Debug';
		act: [ :list | list displayValue do: [ :each | each run ] displayingProgress: 'Running examples ...'. list update ] on: $r command shift entitled: 'Run all';
		send: [ :each | (each isKindOf: GTExampleWithResult) ifTrue: [ each example ] ifFalse: [ each ] ]
]
