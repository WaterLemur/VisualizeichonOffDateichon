Shader "UI/Bar Graph"
{
    Properties
    {
        _Value ("Value", Range(0,1)) = 0.5

        _FillColor ("Fill Color", Color) = (0.2, 0.6, 1, 1)
        _BackgroundColor ("Background Color", Color) = (0.15, 0.15, 0.15, 1)

        _BorderSize ("Border Size", Range(0,0.1)) = 0.02
        _CornerRadius ("Corner Radius", Range(0,0.5)) = 0.05

        _MainTex ("Texture", 2D) = "white" {}
    }

    SubShader
    {
        Tags
        {
            "Queue"="Transparent"
            "IgnoreProjector"="True"
            "RenderType"="Transparent"
            "PreviewType"="Plane"
            "CanUseSpriteAtlas"="True"
        }

        Blend SrcAlpha OneMinusSrcAlpha
        Cull Off
        ZWrite Off

        Pass
        {
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            float _Value;

            float4 _FillColor;
            float4 _BackgroundColor;

            float _BorderSize;
            float _CornerRadius;

            v2f vert(appdata v)
            {
                v2f o;

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;

                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float2 uv = i.uv;

                // Border
                bool border =
                    uv.x < _BorderSize ||
                    uv.x > 1.0 - _BorderSize ||
                    uv.y < _BorderSize ||
                    uv.y > 1.0 - _BorderSize;

                // Background
                fixed4 color = _BackgroundColor;

                // Filled portion
                if (uv.x < _Value)
                {
                    color = _FillColor;
                }

                // Border overrides fill
                if (border)
                {
                    color = _BackgroundColor;
                }

                return color;
            }

            ENDCG
        }
    }
}