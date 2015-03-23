"
It holds one page of code. It is the model behind the Playground.

It also knows how to store itself on disk, and every time its content changes, it updates the corresponding file.
"
Class {
	#name : #GTPlayPage,
	#superclass : #Object,
	#instVars : [
		'content',
		'fileName',
		'creationTime',
		'modificationTime',
		'publishedUrl'
	],
	#category : #'GT-Playground'
}

{ #category : #private }
GTPlayPage class >> basicLoadFromPublishUrl: aString [
	^ GTPlayPage new 
		publishedUrl: aString;
		saveContent: (GTUrlProvider new get: aString)
		yourself
]

{ #category : #'instance creation' }
GTPlayPage class >> creationTimeFrom: aFileReference [
	^ [ self creationTimeFromString: aFileReference basenameWithoutExtension ] 
		on: Error 
		do: [ aFileReference creationTime ]
]

{ #category : #'instance creation' }
GTPlayPage class >> creationTimeFromString: aString [
	" this is really ugly, but hopefully only a temporary solution untill we come up with somthing more reliable and more beautiful "
	| subexpressions |
	subexpressions := OrderedCollection new.
	'(\d+)-(\d+)-(\d+)T(\d+)-(\d+)-(\d+)(-(\d+))?([-+]\d+)-(\d+)(-(\d+))?' asRegex 
		matchesIn: aString
		subexpressionsDo: [ :expression :expressionFragments | 
			subexpressions addAll: (expressionFragments collect: [ :each | 
				[ each squeezeOutNumber ] on: Error do: [ 0 ] ]) ].
	^ DateAndTime 
		year: subexpressions first 
		month: subexpressions second 
		day: subexpressions third 
		hour: subexpressions fourth 
		minute: subexpressions fifth 
		second: subexpressions sixth 
		nanoSecond: subexpressions eighth * 100000 " 7 == full match "
		offset: (Duration 
						days: 0 
						hours: subexpressions ninth 
						minutes: (subexpressions at: 10) 
						seconds: (subexpressions at: 12)) " 11 == full match "
]

{ #category : #'accessing-dynamic' }
GTPlayPage class >> fileExtension [
	^ 'ph'
]

{ #category : #'instance creation' }
GTPlayPage class >> fromFileReference: aFileReference [
	^ GTPlayPage new 
		fileName: aFileReference basename;
		content: (aFileReference readStreamDo: #contents); 
		creationTime: (self creationTimeFrom: aFileReference);
		modificationTime: aFileReference modificationTime;
		yourself
]

{ #category : #examples }
GTPlayPage class >> gtExampleEmpty [
	<example: 'Empty'>
	^ self new
]

{ #category : #'instance creation' }
GTPlayPage class >> loadFromPublishUrl: aString [
	^ [ self basicLoadFromPublishUrl: aString ] 
		on: Error 
		do: [ nil ]
]

{ #category : #'instance creation' }
GTPlayPage class >> loadFromPublishUrl: aString thenDo: aBlock [
	| page |
	page := self loadFromPublishUrl: aString.
	page ifNotNil: [ aBlock value: page ].
	^ page
]

{ #category : #'compatibility-tools' }
GTPlayPage >> acceptContents: aStringOrtext [

	self flag: #TODO. "Need support for what lies in the comment down here"
	"self fileName ifNotNil: [ self saveString: aStringOrtext toFile: self fileName ].

	acceptAction ifNotNil:[acceptAction value: aStringOrtext]."
	self saveContent: aStringOrtext.
	^ true
]

{ #category : #'compatibility-tools' }
GTPlayPage >> cacheDirectory [
	self deprecated: 'use: #fileDirectory instead'.
	^ self fileDirectory
]

{ #category : #accessing }
GTPlayPage >> content [
	" lazy for better backward/forward-compatibility "
	^ content ifNil: [ self defaultContent ]
]

{ #category : #accessing }
GTPlayPage >> content: aString [
	content := aString
]

{ #category : #'accessing-dynamic' }
GTPlayPage >> contentString [
	" strange, sometimes #content is aText not aString ! "
	^ self content asString
]

{ #category : #accessing }
GTPlayPage >> creationTime [
	" lazy for better backward/forward-compatibility "
	^ creationTime ifNil: [ creationTime := self defaultCreationTime ]
]

{ #category : #accessing }
GTPlayPage >> creationTime: anObject [
	creationTime := anObject
]

{ #category : #'accessing-defaults' }
GTPlayPage >> defaultContent [
	^ ''
]

{ #category : #'accessing-defaults' }
GTPlayPage >> defaultCreationTime [
	^ self defaultTimestamp
]

{ #category : #'accessing-defaults' }
GTPlayPage >> defaultFileName [
	^ self title , '.' , self fileExtension
]

{ #category : #'accessing-defaults' }
GTPlayPage >> defaultModificationTime [
	^ self creationTime
]

{ #category : #'accessing-defaults' }
GTPlayPage >> defaultPublishedUrl [
	^ ''
]

{ #category : #'accessing-defaults' }
GTPlayPage >> defaultTimestamp [
	^ DateAndTime now
]

{ #category : #private }
GTPlayPage >> deleteFromFileSystem [
	self fileReference ensureDelete
]

{ #category : #'accessing-dynamic' }
GTPlayPage >> fileDirectory [
	^ GTPlayBook cacheDirectory
]

{ #category : #'accessing-dynamic' }
GTPlayPage >> fileExtension [
	^ self class fileExtension
]

{ #category : #accessing }
GTPlayPage >> fileName [
	" lazy for better backward/forward-compatibility "
	^ fileName ifNil: [ fileName := self defaultFileName ]
]

{ #category : #accessing }
GTPlayPage >> fileName: anObject [
	fileName := anObject
]

{ #category : #'accessing-dynamic' }
GTPlayPage >> fileReference [
	^ self fileDirectory / self fileName
]

{ #category : #ui }
GTPlayPage >> gtDisplayOn: stream [
	stream nextPutAll: (self contentString copyReplaceAll: String cr with: String space)
]

{ #category : #ui }
GTPlayPage >> gtInspectorContentIn: composite [
	<gtInspectorPresentationOrder: 0>
	composite pharoPlayground 
		title: 'Content';
		display: #content;
		installGoAction;
		installDefaultSelectionActions
]

{ #category : #initializing }
GTPlayPage >> initialize [
	super initialize.
	
	self content: self defaultContent.
	self creationTime: self defaultCreationTime.
	self modificationTime: self defaultModificationTime
]

{ #category : #testing }
GTPlayPage >> isInteresting [
	^ self contentString trimBoth isEmpty not
]

{ #category : #accessing }
GTPlayPage >> modificationTime [
	" lazy for better backward/forward-compatibility "
	^ modificationTime ifNil: [ modificationTime := self defaultModificationTime ]
]

{ #category : #accessing }
GTPlayPage >> modificationTime: anObject [
	modificationTime := anObject
]

{ #category : #actions }
GTPlayPage >> publish [
	(self confirm: 'Publish playground content to the cloud?')
        ifFalse: [ ^ self ].
    self content ifEmpty: [ 
        self inform: 'Nothing was published because the playground is empty'.
        ^ self ].
    Clipboard clipboardText: (publishedUrl := (GTUrlProvider new post: self contentString) asString).
    self inform: publishedUrl , ' was published and the url was copied to clipboard'
]

{ #category : #accessing }
GTPlayPage >> publishedUrl [
	^ publishedUrl ifNil: [ self defaultPublishedUrl ]
]

{ #category : #accessing }
GTPlayPage >> publishedUrl: anObject [
	publishedUrl := anObject
]

{ #category : #actions }
GTPlayPage >> save [
	self content isEmpty
		ifTrue: [ self deleteFromFileSystem ]
		ifFalse: [ self writeToFileSystem ]
]

{ #category : #actions }
GTPlayPage >> saveContent: aStringOrText [
	self modificationTime: self defaultTimestamp.
	self content: aStringOrText.
	self save.
]

{ #category : #'compatibility-tools' }
GTPlayPage >> silentContent: aStringOrtext [
	self deprecated: 'use: #content: instead (has no side-effects)'.
	self content: aStringOrtext
]

{ #category : #'accessing-dynamic' }
GTPlayPage >> title [
	^ (self creationTime asString copyReplaceAll: ':' with: '-') copyReplaceAll: '.' with: '-'
]

{ #category : #private }
GTPlayPage >> writeToFileSystem [
	self fileReference writeStreamDo: [ :stream | 
		stream 
			truncate; 
			nextPutAll: self contentString ]
]
