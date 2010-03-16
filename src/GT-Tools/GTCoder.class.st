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
			display: [ :package | package classes ];
			format: [ :each :package |
				(each packageFromOrganizer: RMockFilledPackageOrganizer default) ~= package
					ifTrue: [Text string: each name asString attribute: TextEmphasis italic]
					ifFalse: [each name asString] ]
				].
	browser transmit to: #methods; from: #packages; from: #classes; andShow: [ :a | 
		a list 
			title: 'Instance';
			display: [ :package :class | 
				(package extensionMethodsForClass: class) asOrderedCollection ,
				(package definedMethodsForClass: class) asOrderedCollection ];
			format: [:each :package |
				(each isExtensionInPackage: package ) 
					ifTrue: [Text string: each selector asString attribute: TextEmphasis italic]
					ifFalse: [each selector asString] ].
		a list 
			title: 'Meta';
			display: [ :package :class | (package extensionMethodsForClass: class) asOrderedCollection ,
				(package definedMethodsForClass: class theMetaClass) asOrderedCollection ];
			format: [:each :package |
				(each isExtensionInPackage: package ) 
					ifTrue: [Text string: each selector attribute: TextEmphasis italic]
					ifFalse: [each selector asString] ] ]. 
	^ browser
]
