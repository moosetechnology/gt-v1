Extension { #name : #CatalogProject }

{ #category : #'*GT-InspectorExtensions-Core' }
CatalogProject class >> gtBasicExample [
	<gtExample>
	^ self new fromDictionary: 
		(Dictionary new
			add: ('packageName'->'ConfigurationOfGTInspector'); 
			add: ('name'->'GTInspector'); 
			add: ('repositoryUrl'->'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo50/main'); 
			yourself)
]