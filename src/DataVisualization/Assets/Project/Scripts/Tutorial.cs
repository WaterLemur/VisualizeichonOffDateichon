using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Runtime.ExceptionServices;
using Unity.VisualScripting;
using UnityEngine;

public enum TutorialStage
{
    Intro,
    Cities,
    Resources,
    Info,
    Help,
    Movement,
    Ready
}


public class Tutorial : MonoBehaviour
{    
    [SerializeField] TutorialStage stage = TutorialStage.Intro;
    
    [Header("References")]
    [SerializeField] MobileCameraController mobileCamera;
    [Space(5)]

    [SerializeField] GameObject background;
    [SerializeField] GameObject intro;
    [SerializeField] GameObject cities;
    [SerializeField] GameObject resources;
    [SerializeField] GameObject info;
    [SerializeField] GameObject help;
    [SerializeField] GameObject movement;
    [SerializeField] GameObject ready; 
    [Space(5)]

    [SerializeField] Transform cam;
    [SerializeField] Transform camPos;


    // Start is called before the first frame update
    void Start()
    {
        TutorialSetup();
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void TutorialSetup()
    {
        background.SetActive(true);
        intro.SetActive(true);

        mobileCamera.canMove = false;
        cam.position = camPos.position;
    }

    public void BtnAccept()
    {
        Debug.Log("Button: Accept");


        switch(stage)
        {
            case TutorialStage.Intro:
                stage = TutorialStage.Cities;
                intro.SetActive(false);
                cities.SetActive(true);
                break;

            case TutorialStage.Cities:
                stage = TutorialStage.Resources;
                cities.SetActive(false);
                resources.SetActive(true);
                break;
            
            case TutorialStage.Resources:
                stage = TutorialStage.Info;
                resources.SetActive(false);
                info.SetActive(true);
                break;

            case TutorialStage.Info:
                stage = TutorialStage.Help;
                info.SetActive(false);
                help.SetActive(true);
                break;
            
            case TutorialStage.Help:
                stage = TutorialStage.Movement;
                help.SetActive(false);
                movement.SetActive(true);
                break;

            case TutorialStage.Movement:
                stage = TutorialStage.Ready;
                movement.SetActive(false);
                ready.SetActive(true);
                break;

            case TutorialStage.Ready:
                stage = TutorialStage.Intro;
                ready.SetActive(false);
                background.SetActive(false);

                mobileCamera.canMove = true;
                break;
        }
    }
}
