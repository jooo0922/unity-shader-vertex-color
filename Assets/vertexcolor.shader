Shader "Custom/vertexcolor"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard noambient // 앰비언트 컬러(구석진 표면에 그림자를 더해주는 기술)의 영향을 없애서 온전한 컬러가 보일 수 있도록 한 것! (버텍스 컬러를 받아와서 계산해준 색상을 제대로 확인해야 하니까!) 

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float4 color:COLOR;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            // o.Albedo = c.rgb; // 조명의 영향을 받는 컬러이기 때문에, 얘한테 색상값을 할당하기 보다는, o.Emission(자체발광)에 할당해야 원래의 색을 더 정확하게 볼 수 있음. -> 둘다 살려두면 두 색이 합쳐져서 하얗게 보이니 둘 중 하나는 주석처리 해야됨!
            o.Emission = IN.color.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}

// 버텍스에 컬러데이터를 지정해줬다고 해서(그런 버텍스 페인팅 작업을 유니티에서 해줬건, 3d 모델링 툴에서 해줬건) 
// 해당 모델을 유니티에 가져온다거나 THREE.JS 같은 3d 엔진에서 불러와도 바로 색상이 적용되지는 않음.
// 유니티 같은 경우, Input 구조체에서 버텍스 컬러데이터를 받는 변수를 가져와서, 
// 그거를 o.Emission 이나 o.Albedo 에 넣어줘야 비로소 해당 버텍스 색상이 적용되고,
// 각 버텍스들 사이의 픽셀도 해당 버텍스 컬러값들을 보간한 색상이 렌더링되는 것임!