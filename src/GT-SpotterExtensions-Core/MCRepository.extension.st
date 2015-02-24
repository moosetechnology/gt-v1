Extension { #name : #MCRepository }

{ #category : #'*GT-SpotterExtensions-Core' }
MCRepository >> gtDisplayOn: aStream [
	aStream nextPutAll: self description
]

{ #category : #'*GT-SpotterExtensions-Core' }
MCRepository >> spotterMonticelloPackagesFor: aStep [
	<bug: 'this will not work as spotter terminates the process prematurely - remote filelisting is slow'>
	<demoOnly>
	<spotterOrder: 1>
	aStep listProcessor
		title: 'packages';
		allCandidates: [ self allFileNamesOrCache ];
		itemName: [ :item | item asString ];
		filter: GTFilterSubstring
]
