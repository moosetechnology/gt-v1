Extension { #name : #RPackageTag }

{ #category : #'*GT-SpotterExtensions-Core' }
RPackageTag >> spotterClassesFor: aStep [
	<spotterOrder: 20>
	aStep listProcessor
			allCandidates: [ self classes sorted: [ :a :b | a name < b name ] ];
			title: 'Classes';
			filterUsing: GTFilterSubstring
]
