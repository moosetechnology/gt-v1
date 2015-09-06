Extension { #name : #AbstractNautilusUI }

{ #category : #'*GT-Inspector-Examples-UI' }
AbstractNautilusUI classSide >> examplesClassMenu: aBuilder [
	<contextMenu>
	<nautilusGlobalClassMenu>
	^ GTExampleNautilus new
		onClass: aBuilder;
		yourself
]

{ #category : #'*GT-Inspector-Examples-UI' }
AbstractNautilusUI classSide >> examplesMethodMenu: aBuilder [
	<contextMenu>
	<nautilusGlobalMethodMenu>
	^ GTExampleNautilus new
		onCompiledMethod: aBuilder;
		yourself
]

{ #category : #'*GT-Inspector-Examples-UI' }
AbstractNautilusUI classSide >> examplesPackageMenu: aBuilder [
	<contextMenu>
	<nautilusGlobalPackageMenu>
	^ GTExampleNautilus new
		onPackage: aBuilder;
		yourself
]
