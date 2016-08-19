Extension { #name : #GTExamplePackageSubject }

{ #category : #'*GT-Examples-Examples' }
GTExamplePackageSubject classSide >> exampleFromPackage [
	<gtExample>
	^ GTExamplePackageSubject fromPackage: RPackage allInstances anyOne
]

{ #category : #'*GT-Examples-Examples' }
GTExamplePackageSubject classSide >> exampleFromPackageNamed [
	<gtExample>
	^ GTExamplePackageSubject fromPackageNamed: 'GT-Examples'
]
