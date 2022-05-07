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
        #pragma surface surf Standard noambient // �ں��Ʈ �÷�(������ ǥ�鿡 �׸��ڸ� �����ִ� ���)�� ������ ���ּ� ������ �÷��� ���� �� �ֵ��� �� ��! (���ؽ� �÷��� �޾ƿͼ� ������� ������ ����� Ȯ���ؾ� �ϴϱ�!) 

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float4 color:COLOR;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            // o.Albedo = c.rgb; // ������ ������ �޴� �÷��̱� ������, ������ ������ �Ҵ��ϱ� ���ٴ�, o.Emission(��ü�߱�)�� �Ҵ��ؾ� ������ ���� �� ��Ȯ�ϰ� �� �� ����. -> �Ѵ� ����θ� �� ���� �������� �Ͼ�� ���̴� �� �� �ϳ��� �ּ�ó�� �ؾߵ�!
            o.Emission = IN.color.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
