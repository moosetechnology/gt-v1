Class {
	#name : #GTACustomizedSpotterExtensionCommand,
	#superclass : #GTACommand,
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #execute }
GTACustomizedSpotterExtensionCommand >> clean [
	self session do: [ :eachEvent | 
		eachEvent isCategorySelection ifTrue: [ eachEvent removeCustomizedSpotterExtension ] ]
]

{ #category : #'as yet unclassified' }
GTACustomizedSpotterExtensionCommand >> execute [
	| existingExtensions |
	existingExtensions := GTATool spotterExtensionTitles.
	self session do: [ :eachEvent |
		eachEvent isCategorySelection ifTrue: [ 
			(existingExtensions includes: eachEvent categoryLabel) ifFalse: [ 
				eachEvent setCustomizedSpotterExtension.
			]
		]
	]
]
