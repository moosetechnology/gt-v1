"
This is a helper class that provides dynamically setting entries for all processors defined in the image. The user can use the settings browser to turn each processor on/off.

To achieve this, the class side keeps track of disabledExtensions.

As each setting requires selectors for setting/getting values, the class side implements a doesNotUnderstand: and maintains the disabledExtensions list.
"
Class {
	#name : #GTSpotterExtensionSettings,
	#superclass : #Object,
	#classInstVars : [
		'disabledExtensions'
	],
	#category : #'GT-Spotter-Model'
}

{ #category : #settings }
GTSpotterExtensionSettings class >> catalogSettingsOn: aBuilder [  
	<systemsettings>  
	(aBuilder group: #gtspotter)
		parent: #gt;
		label: 'GT Spotter extensions';
		description: 'All extensions of GT Spotter';
		with: [ 
			GTSpotter spotterExtendingMethods do: [ :each |
				(aBuilder setting: (each methodClass name, '_', each selector allButLast) asSymbol)
							target: self;
							label: each displayString;
							description: each sourceCode;
							default: true.
			]				
		]
]

{ #category : #settings }
GTSpotterExtensionSettings class >> disabledExtensions [
	^ disabledExtensions ifNil: [ disabledExtensions := Set new ]
]

{ #category : #settings }
GTSpotterExtensionSettings class >> doesNotUnderstand: aMessage [
	aMessage arguments isEmpty
		ifTrue: [ ^ (self disabledExtensions includes: aMessage selector) not ].
	aMessage arguments size = 1
		ifTrue: [ ^ 
			aMessage arguments first 
				ifTrue: [ self disabledExtensions remove: aMessage selector allButLast ]
				ifFalse: [ self disabledExtensions add: aMessage selector allButLast ] ].
	^ super doesNotUnderstand: aMessage
]

{ #category : #settings }
GTSpotterExtensionSettings class >> shouldSpotterIgnoreProcessorDefinedInMethod: aCompiledMethod [
	^ self disabledExtensions includes: aCompiledMethod methodClass name, '_', aCompiledMethod selector allButLast
]
