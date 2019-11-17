// Based on the work of bac9-flcl and Dolkar
// http://forum.unity3d.com/threads/how-do-i-write-a-normal-decal-shader-using-a-newly-added-unity-5-2-finalgbuffer-modifier.356644/page-2

Shader "Lux/Deferred Decals/Standard Lighting/MixMapping Full Features" 
{
	Properties 
	{

	//	Lux primary texture set
		[Space(4)]
		[Header(Primary Texture Set _____________________________________________________ )]
		[Space(4)]
		_Color ("Color", Color) = (1,1,1,1)
		[Space(4)]
		_MainTex ("Albedo (RGB) Alpha (A)", 2D) = "white" {}
		[NoScaleOffset] _BumpMap ("Normalmap", 2D) = "bump" {}
		_BumpScale("Scale", Float) = 1.0

		[Toggle(_GLOSSYREFLECTIONS_OFF)] _EnableSpecGloss("Enable Spec Smoothness Maps", Float) = 0.0
		[Lux_HelpDrawer] _HelpSnowMapping ("Enabling or disabling Spec Smoothness Maps will effect both Texture Sets.", Float) = 0
		[Space(2)]
		[NoScaleOffset] _SpecGlossMap("    Specular (RGB) Smoothness (A)", 2D) = "black" {}
		_SpecColor("    Specular", Color) = (0.2,0.2,0.2)
		_Glossiness("    Smoothness", Range(0.0, 1.0)) = 0.5

	//	Lux mix mapping - secondary texture set
		[Space(4)]
		[Header(Secondary Texture Set ___________________________________________________ )]
		[Space(4)]
		_Color2 ("Color", Color) = (1,1,1,1)
		[Space(4)]
	//	We do not use a 2nd UV set nor individual tiling here, so [NoScaleOffset]
	//	[NoScaleOffset] 
		_DetailAlbedoMap("Detail Albedo (RGB)", 2D) = "grey" {}
		[NoScaleOffset] _DetailNormalMap("Normal Map", 2D) = "bump" {}
		_DetailNormalMapScale("Scale", Float) = 1.0
		[NoScaleOffset] _SpecGlossMap2 ("    Specular (RGB) Smoothness (A)", 2D) = "black" {}
		_Glossiness2("    Smoothness", Range(0.0, 1.0)) = 0.5
		_SpecColor2("    Specular", Color) = (0.2,0.2,0.2)

	//	Lux parallax extrusion properties
		[Space(4)]
		[Header(Parallax Extrusion ______________________________________________________ )]
		[Space(4)]
		[NoScaleOffset] _ParallaxMap ("Height (G) Mix Mapping: Height2 (A)", 2D) = "white" {}
		[Lux_HelpDrawer] _HelpMixMapping ("MixMapping is driven by vertex color red.", Float) = 0
		[Space(2)]
		_UVRatio("UV Ratio (XY) Scale(Z)", Vector) = (1, 1, 1, 0)
		_ParallaxTiling ("Mask Tiling", Float) = 1
		_Parallax ("Height Scale", Range (0.0, 0.1)) = 0.02
		[Space(4)]
		[Toggle(EFFECT_BUMP)] _EnablePOM("Enable POM", Float) = 0.0
		[IntRange] _LinearSteps("- Linear Steps", Range(4, 64)) = 20

	//	Lux dynamic weather pr perties

	//	Lux Snow
		[Space(4)]
		[Header(Dynamic Snow ______________________________________________________ )]
		[Space(4)]
		[Enum(Local Space,0,World Space,1)] _SnowMapping ("Mapping", Float) = 0
		_SnowSlopeDamp("Snow Slope Damp", Range (0.0, 8.0)) = 1.0
		[Lux_HelpDrawer] _HelpSnowMapping ("Snow may be masked by vertex color blue.", Float) = 0
		[Space(2)]
		[Lux_SnowAccumulationDrawer] _SnowAccumulation("Snow Accumulation", Vector) = (0,1,0,0)
		[Space(4)]
		[Lux_TextureTilingDrawer] _SnowTiling ("Snow Tiling", Vector) = (2,2,0,0)
		_SnowNormalStrength ("Snow Normal Strength", Range (0.0, 2.0)) = 1.0
		[Lux_TextureTilingDrawer] _SnowMaskTiling ("Snow Mask Tiling", Vector) = (0.3,0.3,0,0)
		[Lux_TextureTilingDrawer] _SnowDetailTiling ("Snow Detail Tiling", Vector) = (4.0,4.0,0,0)
		_SnowDetailStrength ("Snow Detail Strength", Range (0.0, 1.0)) = 0.5
		_SnowOpacity("Snow Opacity", Range (0.0, 1.0)) = 0.5

	//	Lux Wetness
		[Space(4)]
		[Header(Dynamic Wetness ______________________________________________________ )]
		[Space(4)]
		_WaterSlopeDamp("Water Slope Damp", Range (0.0, 1.0)) = 0.5
		[Lux_HelpDrawer] _HelpWater ("Puddles are masked by vertex color green.", Float) = 0
		[Space(2)]
//	PuddleMasks are taken from vertex color in this shader.
//		[Toggle(LUX_PUDDLEMASKTILING)] _EnableIndependentPuddleMaskTiling("Enable independent Puddle Mask Tiling", Float) = 0.0
//		_PuddleMaskTiling ("- Puddle Mask Tiling", Float) = 1

		[Header(Texture Set 1)]
		_WaterColor("Water Color (RGB) Opacity (A)", Color) = (0,0,0,0)
		[Lux_WaterAccumulationDrawer] _WaterAccumulationCracksPuddles("Water Accumulation in Cracks and Puddles", Vector) = (0,1,0,1)

		[Space(4)]
		_Lux_FlowNormalTiling("Flow Normal Tiling", Float) = 2.0
		_Lux_FlowSpeed("Flow Speed", Range (0.0, 2.0)) = 0.05
		_Lux_FlowInterval("Flow Interval", Range (0.0, 8.0)) = 1
		_Lux_FlowRefraction("Flow Refraction", Range (0.0, 0.1)) = 0.02
		_Lux_FlowNormalStrength("Flow Normal Strength", Range (0.0, 2.0)) = 1.0

	//  Mix mapping enabled so we need a 2nd Input
		[Header(Texture Set 2)]
		_WaterColor2("Water Color (RGB) Opacity (A)", Color) = (0,0,0,0)
		[Lux_WaterAccumulationDrawer] _WaterAccumulationCracksPuddles2("Water Accumulation in Cracks and Puddles", Vector) = (0,1,0,1)
		
		[Space(4)]
		_Lux_FlowNormalTiling("Flow Normal Tiling", Float) = 2.0
		_Lux_FlowSpeed("Flow Speed", Range (0.0, 2.0)) = 0.05
		_Lux_FlowInterval("Flow Interval", Range (0.0, 8.0)) = 1
		_Lux_FlowRefraction("Flow Refraction", Range (0.0, 0.1)) = 0.02
		_Lux_FlowNormalStrength("Flow Normal Strength", Range (0.0, 2.0)) = 1.0
	}
	
	SubShader 
	{

//	We could use AlphaTest+1 to avoid problems with alpha tested geometry shining through as we do not write to depth

		Tags {"Queue"="AlphaTest+1" "IgnoreProjector"="True" "RenderType"="Opaque" "ForceNoShadowCasting"="True"}
		LOD 300
//		No Offset in case you do not use flat geometry that exactely matches underlying geometry
//		Offset -1, -1


//	First pass blends albedo, specular color, normal and emission into the gbuffer based on the alpha mask
//	But it also influences the alpha channels of the given outputs:
//	diffuse.a 	= occlusion
//	specular.a 	= smoothness
//	normal.a 	= material ID
//	So we have to "correct" the alpha values in a second pass

		Blend SrcAlpha OneMinusSrcAlpha, Zero OneMinusSrcAlpha
//	Use Zwrite On in case you do not use use flat geometry
		Zwrite On
		// Zwrite Off
		CGPROGRAM

		#pragma surface surf LuxStandardSpecular finalgbuffer:DecalFinalGBuffer vertex:vert exclude_path:forward exclude_path:prepass noshadow noforwardadd keepalpha
		#pragma target 3.0

		// Distinguish between simple parallax mapping and parallax occlusion mapping
		#pragma shader_feature _ EFFECT_BUMP
		#define _SNOW
		#define _WETNESS_FULL

	//	Enable mix mapping 
		#define GEOM_TYPE_BRANCH_DETAIL
	//  Sample Spec Gloss or not
		#pragma shader_feature _ _GLOSSYREFLECTIONS_OFF


		// Allow independed puddle mask tiling
//		#pragma shader_feature _ LUX_PUDDLEMASKTILING

		#include "../Lux Core/Lux Config.cginc"
		#include "../Lux Core/Lux Lighting/LuxStandardPBSLighting.cginc"
		#include "../Lux Core/Lux Setup/LuxStructs.cginc"
		#include "../Lux Core/Lux Utils/LuxUtils.cginc"
		#include "../Lux Core/Lux Features/LuxParallax.cginc"
		#include "../Lux Core/Lux Features/LuxDynamicWeather.cginc"

		struct Input {
			float4 lux_uv_MainTex;			// Here we have 2 channels left
			float3 viewDir;
			float3 worldNormal;
			float3 worldPos;
			INTERNAL_DATA
			// Lux
			float4 color : COLOR0;			// Important: declare color expilicitely as COLOR0
			float2 lux_DistanceScale;		// needed by various functions
			float2 lux_flowDirection;		// needed by Water_Flow			
		};

		half4 _Color;
	//	Lux 2.02 new inputs:
	//	As we use sampler bound and sampler free textures we have to declare the main inputs like this.
		UNITY_DECLARE_TEX2D(_MainTex);
		UNITY_DECLARE_TEX2D(_BumpMap);
		float4 _DetailAlbedoMap_ST;


		#if defined(_GLOSSYREFLECTIONS_OFF)
			sampler2D _SpecGlossMap;
		#else

		#endif

		void vert (inout appdata_full v, out Input o) {
			UNITY_INITIALIZE_OUTPUT(Input,o);
			// Lux
			o.lux_uv_MainTex.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
		o.lux_uv_MainTex.zw = TRANSFORM_TEX(v.texcoord, _DetailAlbedoMap);
			// As decals most likely will have very simple geometry we have to fix Unity's dynamic batching bug
			LUX_FIX_BATCHINGBUG
	    	o.color = v.color;
	    	// Calc Tangent Space Rotation
			float3 binormal = cross( v.normal, v.tangent.xyz ) * v.tangent.w;
			float3x3 rotation = float3x3( v.tangent.xyz, binormal, v.normal.xyz );
			// Store FlowDirection
			o.lux_flowDirection = ( mul(rotation, mul(unity_WorldToObject, float4(0,1,0,0)).xyz) ).xy;
			// Store world position and distance to camera
			float3 worldPosition = mul(unity_ObjectToWorld, v.vertex);
			o.lux_DistanceScale.x = distance(_WorldSpaceCameraPos, worldPosition);
			o.lux_DistanceScale.y = length( mul(unity_ObjectToWorld, float4(1.0, 0.0, 0.0, 0.0)) );
		}

		half _BumpScale;
		half _DetailNormalMapScale;

		void surf (Input IN, inout SurfaceOutputLuxStandardSpecular o) 
		{

			// Initialize the Lux fragment structure. Always do this first.
        // 	LUX_SETUP(float2 main UVs, float2 secondary UVs, half3 view direction in tangent space, float3 world position, float distance to camera, float2 flow direction, fixed4 vertex color)
        //	IMPORTANT: As both textures shall use unique UVs we have to pass IN.lux_uv_MainTex.xy and IN.lux_uv_MainTex.zw!
			LUX_SETUP(IN.lux_uv_MainTex.xy, IN.lux_uv_MainTex.zw, IN.viewDir, IN.worldPos, IN.lux_DistanceScale.x, IN.lux_flowDirection, IN.color, IN.lux_DistanceScale.y)

		//	We use the LUX_PARALLAX macro which handles PM or POM and sets lux.height, lux.puddleMaskValue and lux.mipmapValue
			LUX_PARALLAX

		//	LUX_PARALLAX sets puddleMaskValue to texture input, so we have to overwrite it here.
			lux.puddleMaskValue = IN.color.g;

		//  ///////////////////////////////
        //  From now on we should use lux.finalUV (float4!) to do our texture lookups.

        	// As we want to to accumulate snow according to the per pixel world normal we have to get the per pixel normal in tangent space up front using extruded final uvs from LUX_PARALLAX
			//  Lux 2.02 new inputs: As we use sampler bound and sampler free texture lookups we have to declare the texture lookups like this:
			
			/*
			o.Normal = UnpackNormal( 
				lerp( UNITY_SAMPLE_TEX2D(_BumpMap, lux.finalUV.xy),
					  UNITY_SAMPLE_TEX2D_SAMPLER (_DetailNormalMap, _BumpMap, lux.finalUV.xy),
					  lux.mixmapValue.y)
			);
			*/

			o.Normal = lerp(
				UnpackScaleNormal( UNITY_SAMPLE_TEX2D(_BumpMap, lux.finalUV.xy), _BumpScale ),
				UnpackScaleNormal( UNITY_SAMPLE_TEX2D_SAMPLER (_DetailNormalMap, _BumpMap, lux.finalUV.xy), _DetailNormalMapScale ),
				lux.mixmapValue.y
			);

		//  Calculate Snow and Water Distrubution and get the refracted UVs in case water ripples and/or water flow are enabled
		//  LUX_INIT_DYNAMICWEATHER(half puddle mask value, half snow mask value, half3 tangent space normal)
			LUX_INIT_DYNAMICWEATHER(lux.puddleMaskValue, IN.color.b, o.Normal)	


		//  ///////////////////////////////
        //  Do your regular stuff

        //	Sample and mix albedo
			fixed4 c = UNITY_SAMPLE_TEX2D (_MainTex, lux.finalUV.xy) * _Color;
			fixed4 d = UNITY_SAMPLE_TEX2D_SAMPLER (_DetailAlbedoMap, _MainTex, lux.finalUV.zw) * _Color2;
			o.Albedo = lerp(c.rgb, d.rgb, lux.mixmapValue.y);

			o.Alpha = c.a * IN.color.a;
			
		//	Sample and mix normal
			/*
			o.Normal = UnpackNormal( 
				lerp( UNITY_SAMPLE_TEX2D(_BumpMap, lux.finalUV.xy),
					  UNITY_SAMPLE_TEX2D_SAMPLER (_DetailNormalMap, _BumpMap, lux.finalUV.zw),
					  lux.mixmapValue.y)
			);
			*/
			o.Normal = lerp(
				UnpackScaleNormal( UNITY_SAMPLE_TEX2D(_BumpMap, lux.finalUV.xy), _BumpScale ),
				UnpackScaleNormal( UNITY_SAMPLE_TEX2D_SAMPLER (_DetailNormalMap, _BumpMap, lux.finalUV.xy), _DetailNormalMapScale ),
				lux.mixmapValue.y
			);

			#if defined(_GLOSSYREFLECTIONS_OFF)
				half4 specGloss = tex2D (_SpecGlossMap, lux.finalUV.xy);
				o.Specular = specGloss.rgb;
			#else 
				o.Specular = lerp(_SpecColor, _SpecColor2, lux.mixmapValue.y);
			#endif

		//	Please note: We do not have to write to o.Smoothness or o.Occlusion in this pass
		//  as these would be coruppted anyway. We will do so in the 2nd pass

		//  ///////////////////////////////

		//	Apply dynamic water and snow
			LUX_APPLY_DYNAMICWEATHER

		}

		void DecalFinalGBuffer (Input IN, SurfaceOutputLuxStandardSpecular o, inout half4 diffuse, inout half4 specSmoothness, inout half4 normal, inout half4 emission)
		{
			diffuse.a = o.Alpha;
			specSmoothness.a = o.Alpha;
			normal.a = o.Alpha;
			emission.a = o.Alpha;
		}

		ENDCG


//	Second Pass
// 	As the first pass blend gbuffer values according to the alpha mask alpha values in the gbuffer are not correct.
//	So the second pass fixes them.

		Blend One One
		ColorMask A

		CGPROGRAM

		#pragma surface surf LuxStandardSpecular finalgbuffer:DecalFinalGBuffer vertex:vert exclude_path:forward exclude_path:prepass noshadow noforwardadd keepalpha
		#pragma target 3.0

		// Distinguish between simple parallax mapping and parallax occlusion mapping
		#pragma shader_feature _ EFFECT_BUMP
		#define _SNOW
		// Second pass does not really need water flow or rain ripples - so we go with simple wetness
		#define _WETNESS_SIMPLE

	//	Enable mix mapping 
		#define GEOM_TYPE_BRANCH_DETAIL

	//  Sample Spec Gloss or not
		#pragma shader_feature _ _GLOSSYREFLECTIONS_OFF

		#include "../Lux Core/Lux Config.cginc"
		#include "../Lux Core/Lux Lighting/LuxStandardPBSLighting.cginc"
		#include "../Lux Core/Lux Setup/LuxStructs.cginc"
		#include "../Lux Core/Lux Utils/LuxUtils.cginc"
		#include "../Lux Core/Lux Features/LuxParallax.cginc"
		#include "../Lux Core/Lux Features/LuxDynamicWeather.cginc"

		struct Input {
			float4 lux_uv_MainTex;			// Here we have 2 channels left
			float3 viewDir;
			float3 worldNormal;
			float3 worldPos;
			INTERNAL_DATA
			// Lux
			float4 color : COLOR0;			// Important: declare color expilicitely as COLOR0
			float2 lux_DistanceScale;		// needed by various functions
			float2 lux_flowDirection;		// needed by Water_Flow			
		};

		half4 _Color;
		sampler2D _MainTex;
		float4 _DetailAlbedoMap_ST;

		UNITY_DECLARE_TEX2D(_BumpMap);

		#if defined(_GLOSSYREFLECTIONS_OFF)
			UNITY_DECLARE_TEX2D(_SpecGlossMap);
		#else
			fixed _Glossiness;
		#endif
		//sampler2D _SpecGlossMap;
		//sampler2D _SpecGlossMap2;

		void vert (inout appdata_full v, out Input o) {
			UNITY_INITIALIZE_OUTPUT(Input,o);
			// Lux
			o.lux_uv_MainTex.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
		o.lux_uv_MainTex.zw = TRANSFORM_TEX(v.texcoord, _DetailAlbedoMap);
			// As decals most likely will have very simple geometry we have to fix Unity's dynamic batching bug
			LUX_FIX_BATCHINGBUG
	    	o.color = v.color;
	    	// Calc Tangent Space Rotation
			float3 binormal = cross( v.normal, v.tangent.xyz ) * v.tangent.w;
			float3x3 rotation = float3x3( v.tangent.xyz, binormal, v.normal.xyz );
			// Store FlowDirection
			o.lux_flowDirection = ( mul(rotation, mul(unity_WorldToObject, float4(0,1,0,0)).xyz) ).xy;
			// Store world position and distance to camera
			float3 worldPosition = mul(unity_ObjectToWorld, v.vertex);
			o.lux_DistanceScale.x = distance(_WorldSpaceCameraPos, worldPosition);
			o.lux_DistanceScale.y = length( mul(unity_ObjectToWorld, float4(1.0, 0.0, 0.0, 0.0)) );
		}

		half _BumpScale;
		half _DetailNormalMapScale;

		void surf (Input IN, inout SurfaceOutputLuxStandardSpecular o) 
		{
			// Initialize the Lux fragment structure. Always do this first.
        // 	LUX_SETUP(float2 main UVs, float2 secondary UVs, half3 view direction in tangent space, float3 world position, float distance to camera, float2 flow direction, fixed4 vertex color)
        //	IMPORTANT: As both textures shall use the same UVs we have to pass IN.lux_uv_MainTex.xy twice!
            LUX_SETUP(IN.lux_uv_MainTex.xy, IN.lux_uv_MainTex.zw, IN.viewDir, IN.worldPos, IN.lux_DistanceScale.x, IN.lux_flowDirection, IN.color, IN.lux_DistanceScale.y)

			// We use the LUX_PARALLAX macro which handles PM or POM and sets lux.height, lux.puddleMaskValue and lux.mipmapValue
			LUX_PARALLAX

			//	LUX_PARALLAX sets puddleMaskValue to texture input, so we have to overwrite it here.
			lux.puddleMaskValue = IN.color.g;

			// As we want to to accumulate snow according to the per pixel world normal we have to get the per pixel normal in tangent space up front using extruded final uvs from LUX_PARALLAX
			// Lux 2.02 new inputs: As we use sampler bound and sampler free texture lookups we have to declare the texture lookups like this:
			/*
			o.Normal = UnpackNormal( 
				lerp( UNITY_SAMPLE_TEX2D(_BumpMap, lux.finalUV.xy),
					  UNITY_SAMPLE_TEX2D_SAMPLER (_DetailNormalMap, _BumpMap, lux.finalUV.zw),
					  lux.mixmapValue.y)
			);
			*/
			o.Normal = lerp(
				UnpackScaleNormal( UNITY_SAMPLE_TEX2D(_BumpMap, lux.finalUV.xy), _BumpScale ),
				UnpackScaleNormal( UNITY_SAMPLE_TEX2D_SAMPLER (_DetailNormalMap, _BumpMap, lux.finalUV.xy), _DetailNormalMapScale ),
				lux.mixmapValue.y
			);

			// Calculate Snow and Water Distribution and get the refracted UVs in case water ripples and/or water flow are enabled
			// LUX_INIT_DYNAMICWEATHER(half puddle mask value, half snow mask value, half3 tangent space normal)
			LUX_INIT_DYNAMICWEATHER(lux.puddleMaskValue, IN.color.b, o.Normal)

		//  ///////////////////////////////
        //  Do your regular stuff:

        //	Here we need only the first albedo - in order to grab the mask
			fixed4 c = tex2D (_MainTex, lux.finalUV.xy) * _Color;
		
			o.Alpha = c.a * IN.color.a;
		

		//	Important: We have to write to o.Normal as otherwise Parallax will be corrupted due to missing matrices
			o.Normal = half3(0,0,1);
			//o.Smoothness = tex2D (_SpecGlossMap, lux.finalUV.xy).a;

			#if defined(_GLOSSYREFLECTIONS_OFF)
				o.Smoothness = 	lerp(
					UNITY_SAMPLE_TEX2D(_SpecGlossMap, lux.finalUV.xy).a,
					UNITY_SAMPLE_TEX2D_SAMPLER (_SpecGlossMap2, _SpecGlossMap, lux.finalUV.zw).a,
					lux.mixmapValue.y
				);
			#else
				o.Smoothness = lerp(_Glossiness, _Glossiness2, lux.mixmapValue.y);
			#endif


		//  ///////////////////////////////

			// Apply dynamic water and snow
			LUX_APPLY_DYNAMICWEATHER

		}

		void DecalFinalGBuffer (Input IN, SurfaceOutputLuxStandardSpecular o, inout half4 diffuse, inout half4 specSmoothness, inout half4 normal, inout half4 emission)
		{
			diffuse.a *= o.Alpha; 			// final Occlusion
			specSmoothness.a *= o.Alpha;	// final Smoothness
			normal.a = 1; 					// Material
		}

		ENDCG
	} 
}