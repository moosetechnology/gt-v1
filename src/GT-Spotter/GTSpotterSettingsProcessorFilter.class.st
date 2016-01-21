Class {
	#name : #GTSpotterSettingsProcessorFilter,
	#superclass : #GTSpotterProcessorFilter,
	#category : #'GT-Spotter-Model'
}

{ #category : #testing }
GTSpotterSettingsProcessorFilter >> configurationBlockForProcessorsCreatedBy: aMethod [
	"No need to configure anything."
	
	^ [ :processor | ]
]

{ #category : #testing }
GTSpotterSettingsProcessorFilter >> shouldEnableProcessorsCreateBy: aMethod [
	"Enable everything."
	
	^ (GTSpotterExtensionSettings shouldSpotterIgnoreProcessorDefinedInMethod: aMethod) not
]
