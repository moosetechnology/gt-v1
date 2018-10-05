Class {
	#name : #BaselineOfGTInspector,
	#superclass : #BaselineOf,
	#category : #BaselineOfGTInspector
}

{ #category : #baselines }
BaselineOfGTInspector >> baseline: spec [
	<baseline>
	
	spec for: #'common' do: [
		spec  
			baseline: 'GTInspectorCore' with: [ 
				spec repository: 'github://moosetechnology/gt-v1/src' ]; 
			baseline: 'Glamour' with: [ 
				spec repository: 'github://moosetechnology/Glamour/src' ];
			baseline: 'Roassal2' with: [ 
				spec repository: 'github://ObjectProfile/Roassal2/src' ];
			project: 'DeepTraverser' with: [
				spec
					className: #ConfigurationOfDeepTraverser;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/Moose/DeepTraverser/main/' ].
		spec 
			package: 'GT-InspectorExtensions-CoreRoassal' with: [
				spec requires: #('GTInspectorCore' 'Glamour' 'Roassal2' ) ] ]

]
