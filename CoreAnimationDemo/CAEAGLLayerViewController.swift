//
//  CAEAGLLayerViewController.swift
//  CoreAnimationDemo
//
//  Created by hao Mac Mini on 2017/2/20.
//  Copyright © 2017年 Vito. All rights reserved.
//

import UIKit
import GLKit
import OpenGLES

class CAEAGLLayerViewController: UIViewController {
    
    @IBOutlet weak var glView: UIView!
    var glContext: EAGLContext!
    var glLayer: CAEAGLLayer!
    var framebuffer: GLuint = 0
    var colorRenderbuffer: GLuint = 0
    var framebufferWidth: GLint = 0
    var framebufferHeight: GLint = 0
    var effect: GLKBaseEffect!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // set up context
        glContext = EAGLContext(api: .openGLES2)
        EAGLContext.setCurrent(glContext)
        
        // set up layer
        glLayer = CAEAGLLayer()
        glLayer.frame = glView.bounds
        glView.layer.addSublayer(glLayer)
        glLayer.drawableProperties = [kEAGLDrawablePropertyRetainedBacking : NSNumber(value: false), kEAGLDrawablePropertyColorFormat : kEAGLColorFormatRGBA8]
        
        // set up base effect
        effect = GLKBaseEffect()
        
        // set up buffers
        setupBuffers()
        
        // draw frame
        drawFrame()
    }
    
    deinit {
        tearDownBuffers()
        EAGLContext.setCurrent(nil)
    }
    
    private func setupBuffers() {
        // set up frame buffer
        glGenBuffers(1, &framebuffer)
        glBindFramebuffer(GLenum(GL_FRAMEBUFFER), framebuffer)
        
        // set up color render buffer
        glGenRenderbuffers(1, &colorRenderbuffer)
        glBindRenderbuffer(GLenum(GL_RENDERBUFFER), colorRenderbuffer)
        
        glFramebufferRenderbuffer(GLenum(GL_FRAMEBUFFER), GLenum(GL_COLOR_ATTACHMENT0), GLenum(GL_RENDERBUFFER), colorRenderbuffer)
        glContext.renderbufferStorage(Int(GL_RENDERBUFFER), from: glLayer)
        
        glGetRenderbufferParameteriv(GLenum(GL_RENDERBUFFER), GLenum(GL_RENDERBUFFER_WIDTH), &framebufferWidth)
        glGetRenderbufferParameteriv(GLenum(GL_RENDERBUFFER), GLenum(GL_RENDERBUFFER_HEIGHT), &framebufferHeight)
        
        // check success
        if glCheckFramebufferStatus(GLenum(GL_FRAMEBUFFER)) != GLenum(GL_FRAMEBUFFER_COMPLETE) {
            print("Failed to make complete framebuffer object \(glCheckFramebufferStatus(GLenum(GL_FRAMEBUFFER)))")
        }
    }
    
    private func tearDownBuffers() {
        glDeleteFramebuffers(1, &framebuffer)
        framebuffer = 0
        
        glDeleteRenderbuffers(1, &colorRenderbuffer)
        colorRenderbuffer = 0
    }
    
    func drawFrame() {
        // bind framebuffer & set viewport
        glBindFramebuffer(GLenum(GL_FRAMEBUFFER), framebuffer)
        glViewport(0, 0, framebufferWidth, framebufferHeight)
        
        // bind shader program
        effect.prepareToDraw()
        
        // clear the screen
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        glClearColor(0, 0, 0, 1)
        
        // set up vertices
        let vertices =
            [
                -0.5, -0.5, -1.0,
                 0.0,  0.5, -1.0,
                 0.5, -0.5, -1.0
            ]
        
        // set up colors
        let colors =
            [
                0.0, 0.0, 1.0,
                1.0, 0.0, 1.0,
                0.0, 1.0, 1.0,
                0.0, 0.0, 1.0
            ]
        
        // draw triangle
        glEnableVertexAttribArray(GLuint(GLKVertexAttrib.position.rawValue))
        
        glEnableVertexAttribArray(GLuint(GLKVertexAttrib.color.rawValue))
        glVertexAttribPointer(GLuint(GLKVertexAttrib.position.rawValue), 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, vertices)
        glVertexAttribPointer(GLuint(GLKVertexAttrib.color.rawValue), 4, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, colors)
        glDrawArrays(GLenum(GL_TRIANGLES), 0, 3)
        
        // present render buffer
        glBindRenderbuffer(GLenum(GL_RENDERBUFFER), colorRenderbuffer)
        glContext.presentRenderbuffer(Int(GL_RENDERBUFFER))
    }
}








