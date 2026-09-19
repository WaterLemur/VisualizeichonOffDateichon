Shader "UI/Donut Graph"
{
    Properties
    {
        _CityA ("City A Value", Float) = 40
        _CityB ("City B Value", Float) = 35
        _CityC ("City C Value", Float) = 25

        _ColorA ("City A Color", Color) = (1,0,0,1)
        _ColorB ("City B Color", Color) = (0,1,0,1)
        _ColorC ("City C Color", Color) = (0,0,1,1)

        _InnerRadius ("Inner Radius", Range(0,1)) = 0.55
        _OuterRadius ("Outer Radius", Range(0,1)) = 0.95

        _Gap ("Division Gap", Range(0,0.05)) = 0.005

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

            sampler2D _MainTex;

            float _CityA;
            float _CityB;
            float _CityC;

            float4 _ColorA;
            float4 _ColorB;
            float4 _ColorC;

            float _InnerRadius;
            float _OuterRadius;
            float _Gap;

            v2f vert(appdata v)
            {
                v2f o;

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;

                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // Move UV origin to center.
                float2 p = i.uv - 0.5;

                // Distance from center.
                float distanceFromCenter = length(p) * 2.0;

                // Discard pixels outside donut.
                if (distanceFromCenter < _InnerRadius ||
                    distanceFromCenter > _OuterRadius)
                {
                    discard;
                }

                // Calculate angle.
                float angle = atan2(p.y, p.x);

                // Convert -PI..PI into 0..1.
                angle = angle / (2.0 * UNITY_PI);

                if (angle < 0)
                    angle += 1.0;

                // Total.
                float total = _CityA + _CityB + _CityC;

                if (total <= 0.0)
                    discard;

                // Convert values into percentages.
                float a = _CityA / total;
                float b = _CityB / total;

                // Segment boundaries.
                float boundaryA = a;
                float boundaryB = a + b;

                // Default color.
                fixed4 color = _ColorC;

                // City A.
                if (angle < boundaryA - _Gap)
                {
                    color = _ColorA;
                }

                // City B.
                else if (angle > boundaryA + _Gap &&
                         angle < boundaryB - _Gap)
                {
                    color = _ColorB;
                }

                // City C.
                else if (angle > boundaryB + _Gap)
                {
                    color = _ColorC;
                }

                // Division gaps.
                else
                {
                    color = fixed4(0, 0, 0, 0);
                }

                return color;
            }

            ENDCG
        }
    }
}