using UnityEngine;


public class SceneIntro : MonoBehaviour
{
    [SerializeField] float _timerLogo = 1.5f;
    bool _isTimerLogo = false;


    void Start()
    {
        // Cursor
        Cursor.lockState = CursorLockMode.None;
        Cursor.visible = false;

        // Set current scene
        //Game.Instance.LastScene =  Game.Instance.CurrentScene;
        //Game.Instance.CurrentScene = SceneList.Intro;
    }


    void Update()
    {
        TimerLogo();
    }
    void TimerLogo()
    {
        if (_timerLogo > 0)
        {
            _timerLogo = _timerLogo - Time.deltaTime;
        }
        else if (_isTimerLogo == false)
        {
            _isTimerLogo = true;
            ScenePersistent.Instance.LoadAndActivate(SceneList.DataView); 
            ScenePersistent.Instance.Unload();
            //ScriptPersistent.Instance.Unload(SceneList.Logo);
        }
    }
}
