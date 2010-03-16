"
self openOn: RMockFilledPackageOrganizer default 
"
Class {
	#name : #GTCoder,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools'
}

{ #category : #'as yet unclassified' }
GTCoder >> browser [ 
	"self openOn: RMockFilledPackageOrganizer default"
	browser := GLMTabulator new.
	browser column: #packages; column: #classes; column: #methods.
	browser transmit to: #packages; andShow: [ :a |
		a list 
			display: [ :organizer | organizer packages asSortedCollection: [:x :y | x packageName < y packageName ] ];
			format: #packageName ].
	browser transmit to: #classes; from: #packages; andShow: [ :a | 
		a list
			display: [ :package | package classes ];
			format: [ :each :package |
				(package extendsClass: each)
					ifTrue: [Text string: each name asString attribute: TextEmphasis italic]
					ifFalse: [each name asString] ] ].
	browser transmit to: #methods; from: #packages; from: #classes; andShow: [ :a | 
		a list 
			title: 'Instance';
			display: [ :package :class | class selectors ];
			format: [:each :package :class |
				(package includesDefinedSelector: each ofClass: class) 
					ifFalse: [Text string: each asString attribute: TextEmphasis italic]
					ifTrue: [each asString] ].
		a list 
			title: 'Meta';
			display: [ :package :class | class theMetaClass selectors ];
			format: [:each :package :class |
				(package includesDefinedSelector: each ofClass: class class) 
					ifFalse: [Text string: each asString attribute: TextEmphasis italic]
					ifTrue: [each asString] ] ].
	^ browser
]
