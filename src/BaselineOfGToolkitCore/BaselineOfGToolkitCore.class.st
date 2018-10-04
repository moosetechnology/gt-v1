Class {
	#name : #BaselineOfGToolkitCore,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitCore
}

{ #category : #baselines }
BaselineOfGToolkitCore >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'GTInspectorCore' with: [ 
				spec repository: 'github://moosetechnology/gt-v1:pharo6/src' ];
			baseline: 'GTPlaygroundCore' with: [ 
				spec repository: 'github://moosetechnology/gt-v1:pharo6/src' ];
			baseline: 'GTSpotter' with: [ 
				spec repository: 'github://moosetechnology/gt-v1:pharo6/src' ];
			baseline: 'GTDebugger' with: [ 
				spec repository: 'github://moosetechnology/gt-v1:pharo6/src' ] ].
]
