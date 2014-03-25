Class {
	#name : #GTMetacellerVersionEditor,
	#superclass : #GLMGlobalBrowserTemplate,
	#instVars : [
		'announcer',
		'version'
	],
	#category : #'GT-Metaceller-Glamour'
}

{ #category : #events }
GTMetacellerVersionEditor >> announce: anAnnouncement [ 
	self announcer announce: anAnnouncement
]

{ #category : #accessing }
GTMetacellerVersionEditor >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
GTMetacellerVersionEditor >> announcer: anObject [
	announcer := anObject
]

{ #category : #building }
GTMetacellerVersionEditor >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Edit ', self version title.
	browser
		act: [ :b | 
			Workspace new
				contents: self helpText;
				openLabel: 'Metaceller version editor help' ]
		icon: GLMUIThemeExtraIcons glamorousHelp
		entitled: 'Help'.
	browser
		row: #versionData;
		row: #details;
		row: #buttons size: 30.
	browser transmit
		to: #versionData;
		andShow: [ :a | self versionDataIn: a ].
	browser transmit
		to: #details;
		andShow: [ :a | self detailsIn: a ].
	browser transmit
		to: #buttons;
		andShow: [ :a | self buttonsIn: a ].
	^ browser
]

{ #category : #building }
GTMetacellerVersionEditor >> buttonsIn: aBrowser [
	aBrowser actionList
		act: [ :entity | self save ] entitled: 'Save';
		act: [ :entity | self cancel ] entitled: 'Cancel';
		yourself	
]

{ #category : #actions }
GTMetacellerVersionEditor >> cancel [
	self browser close
]

{ #category : #building }
GTMetacellerVersionEditor >> detailsForItem: anItem [
	anItem ifNil: [ ^self configuration infoText ].
	anItem isCollection ifTrue: [
		anItem ifEmpty: [ ^self configuration infoText ].
		^anItem inject: Text new into: [ :retVal :each | retVal append: each infoText; append: String cr; yourself ] ].
	^anItem infoText
]

{ #category : #building }
GTMetacellerVersionEditor >> detailsIn: aBrowser [
	aBrowser text
		title: 'Details';
		format: [ :item | self detailsForItem: item ];
		updateOn: GTVersionChanged from: self announcer;
		yourself
]

{ #category : #opening }
GTMetacellerVersionEditor >> entity [
	^self version
]

{ #category : #opening }
GTMetacellerVersionEditor >> openOn: aVersion [
	version := aVersion.
	super openOn: aVersion
]

{ #category : #actions }
GTMetacellerVersionEditor >> save [
	self halt
]

{ #category : #actions }
GTMetacellerVersionEditor >> updateVersion [
	" announce the version has changed "
	self announce: (GTVersionChanged on: self version)
]

{ #category : #accessing }
GTMetacellerVersionEditor >> version [
	^ version
]

{ #category : #accessing }
GTMetacellerVersionEditor >> version: anObject [
	version := anObject
]

{ #category : #building }
GTMetacellerVersionEditor >> versionDataIn: aBrowser [
	aBrowser magritte
		title: 'Version info';
		description: [ :v | v magritteDescription ];
		onAnswer: [ :v :presentation | self updateVersion ]
		yourself
]
