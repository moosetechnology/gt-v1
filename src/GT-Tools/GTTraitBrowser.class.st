Class {
	#name : #GTTraitBrowser,
	#superclass : #Object,
	#category : #'GT-Tools-Prototypes'
}

{ #category : #'initialize-release' }
GTTraitBrowser class >> open [
	^ self new open
]

{ #category : #'initialize-release' }
GTTraitBrowser >> buildBrowser [ 
	|browser|
	browser := GLMFinder new.
	browser fixedSizePanes: 2.
	browser show: [:a | 
		a custom: self innerBrowser].
	^ browser
]

{ #category : #'initialize-release' }
GTTraitBrowser >> innerBrowser [ 
	|stacker browser|
	browser := GLMTabulator new.
	browser row: #classortraitName; row: #navigator span: 20.
	
	stacker := GLMStacker new.
	stacker 
		aPane: #methods;
		aPane: #superclasses;
		aPane: #traits.
		
	stacker transmit to: #methods;
			andShow: [:a | a title: 'methods'. self methodsIn: a].
	stacker transmit to: #superclasses;
			andShow: [:a | a title: 'hierarchy'. self superclassesIn: a].
	stacker transmit to: #traits;
			andShow: [:a | a title: 'traits'. self traitsIn: a].
			
	stacker transmit from: #superclasses; toOutsidePort: #selection.
	stacker transmit from: #traits; toOutsidePort: #selection.
	
	browser transmit to: #classortraitName; andShow: [:a | a label display: [:classortrait | classortrait name]].
	browser transmit to: #navigator; andShow: [:a | a custom: stacker].
	browser transmit from: #navigator; toOutsidePort: #selection.
	
	^ browser
]

{ #category : #'initialize-release' }
GTTraitBrowser >> methodsIn: constructor [
	constructor list
		display: [:class | class localSelectors sorted]
	
]

{ #category : #'initialize-release' }
GTTraitBrowser >> open [
	self buildBrowser openOn: NSCollectionStream 
	
]

{ #category : #'initialize-release' }
GTTraitBrowser >> superclassesIn: constructor [
	constructor list
		whenKindOf: Class;
		display: [:class | class allSuperclasses]
]

{ #category : #'initialize-release' }
GTTraitBrowser >> traitsIn: constructor [
	constructor list
		when: #hasTraitComposition;
		display: #traits
]
