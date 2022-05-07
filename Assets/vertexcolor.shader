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
