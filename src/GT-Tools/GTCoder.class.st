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
			display: [ :organizer | organizer packages ];
			format: #packageName ].
	browser transmit to: #classes; from: #packages; andShow: [ :a | 
		a list
			display: [ :package | package classes  ]].
	browser transmit to: #methods; from: #packages; from: #classes; andShow: [ :a | 
		a list 
			title: 'Instance';
			display: [ :package :class | 
				(package extensionMethodsForClass: class) asOrderedCollection ,
				(package definedMethodsForClass: class) asOrderedCollection ];
			format: #selector .
		a list 
			title: 'Meta';
			display: [ :package :class | (package extensionMethodsForClass: class) asOrderedCollection ,
				(package definedMethodsForClass: class theMetaClass) asOrderedCollection ];
			format: #selector ]. 
	^ browser
]
