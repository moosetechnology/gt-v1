"
Global GT-Chatter settings.
"
Class {
	#name : #GTCSettings,
	#superclass : #Object,
	#classInstVars : [
		'url'
	],
	#category : #'GT-Chatter-Model'
}

{ #category : #settings }
GTCSettings class >> settingsOn: aBuilder [ 
	<systemsettings>
	
	(aBuilder setting: #stringUrl)
		parent: #gt;
		target: self;
		description: 'The url for the Chatter server.' translated;
		label: 'Chatter server URL address'

]

{ #category : #accessing }
GTCSettings class >> stringUrl [
	^ self url asString
]

{ #category : #accessing }
GTCSettings class >> stringUrl: anUrlObject [
	url := anUrlObject ifNotNil: [ anUrlObject asZnUrl ]
]

{ #category : #accessing }
GTCSettings class >> url [
	^ url ifNil: [ url := 'ws://gc.dcc.uchile.cl.:8855' asZnUrl ]
]
