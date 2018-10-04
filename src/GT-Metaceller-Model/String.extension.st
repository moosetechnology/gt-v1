Extension { #name : #String }

{ #category : #'*gt-metaceller-model' }
String >> asMetacellerVersion [
	^GTMetacellerVersionName on: self
]
