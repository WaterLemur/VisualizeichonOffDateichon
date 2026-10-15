using UnityEngine;
using UnityEngine.SceneManagement;
using System.Collections;


public class SceneIntro : MonoBehaviour
{
    [SerializeField] float _timerLogo = 1.5f;
    bool _isTimerLogo = false;


    void Start()
    {
        // Cursor
        Cursor.lockState = CursorLockMode.None;
        Cursor.visible = false;
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
            SceneManager.LoadSceneAsync(SceneList.DataView.ToString(), LoadSceneMode.Additive);
            SceneManager.UnloadSceneAsync(SceneList.Intro.ToString());
        }
    }
}
