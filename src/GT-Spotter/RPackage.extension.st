Extension { #name : #RPackage }

{ #category : #'*GT-Spotter' }
RPackage >> spotterPreviewIn: aCanvas [

	aCanvas list
		display: [:each | each classes  "self classes"];
		format: [ :aClass | aClass gtDisplayString  ]
]
