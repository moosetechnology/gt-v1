Extension { #name : #MCRepository }

{ #category : #'*GT-SpotterExtensions-Core' }
MCRepository >> gtDisplayOn: aStream [
	aStream nextPutAll: self description
]

{ #category : #'*GT-SpotterExtensions-Core' }
MCRepository >> spotterMonticelloPackagesFor: aStep [
	<bug>
	<spotterOrder: 1>
	aStep listProcessor
		title: 'packages';
		allCandidates: [ self allFileNamesOrCache 
			" THIS WILL NOT WORK AS SPOTTE TERMINATES THE PROCESS PREMATURELY" ];
		itemName: [ :item | item asString ];
		matchSubstring
]
