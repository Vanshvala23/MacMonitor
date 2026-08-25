# 🖥️ MacMonitor

A lightweight and modern **macOS system monitor** built with **SwiftUI**. MacMonitor provides real-time information about your Mac's **CPU, memory, disk, and network usage**, with a convenient menu bar interface.

![macOS](https://img.shields.io/badge/macOS-26%2B-000000?style=for-the-badge\&logo=apple\&logoColor=white)
![Swift](https://img.shields.io/badge/Swift-6-orange?style=for-the-badge\&logo=swift\&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-Framework-blue?style=for-the-badge\&logo=swift)
![Xcode](https://img.shields.io/badge/Xcode-26-blue?style=for-the-badge\&logo=xcode\&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

---

## ✨ Features

### 📊 System Monitoring

MacMonitor continuously monitors important system resources:

* 🧠 **CPU Usage**

  * Real-time overall CPU utilization
  * Lightweight monitoring

* 💾 **Memory Usage**

  * Used memory
  * Available memory
  * Memory utilization percentage

* 💿 **Disk Usage**

  * Storage utilization
  * Used disk space
  * Available disk space

* 🌐 **Network Monitoring**

  * Upload activity
  * Download activity
  * Real-time network statistics

### 🧭 Menu Bar

MacMonitor lives directly in the macOS menu bar, giving you quick access to system information without opening a separate application window.

### 🎨 Native SwiftUI Interface

Built entirely with Apple's modern SwiftUI framework for a clean and native macOS experience.

---

## 📸 Preview

> Screenshots coming soon.

Add your screenshots here once the UI is finalized:

```markdown
![MacMonitor Dashboard](Screenshots/dashboard.png)

![MacMonitor Menu Bar](Screenshots/menu-bar.png)
```

---

## 🏗️ Architecture

MacMonitor follows a simple and maintainable SwiftUI architecture.

```text
MacMonitor
│
├── App
│   └── MacMonitorApp.swift
│
├── MenuBar
│   ├── MenuBarView.swift
│   └── MenuBarViewModel.swift
│
├── System
│   ├── CPU Monitoring
│   ├── Memory Monitoring
│   ├── Disk Monitoring
│   └── Network Monitoring
│
├── Views
│   └── SwiftUI Views
│
└── Resources
```

The project separates UI presentation from system monitoring logic, making it easier to extend and maintain.

---

## 🛠️ Tech Stack

| Technology       | Usage                        |
| ---------------- | ---------------------------- |
| **Swift**        | Primary programming language |
| **SwiftUI**      | User interface               |
| **Xcode**        | Development environment      |
| **macOS APIs**   | System statistics            |
| **MenuBarExtra** | Menu bar integration         |

---

## 🚀 Getting Started

### Requirements

Before running MacMonitor, make sure you have:

* macOS
* Xcode 26 or later
* Swift 6+
* A Mac capable of running the required macOS version

### Installation

Clone the repository:

```bash
git clone https://github.com/VanshVala23/MacMonitor.git
```

Navigate into the project:

```bash
cd MacMonitor
```

Open the project in Xcode:

```bash
open MacMonitor.xcodeproj
```

Then:

1. Select the **MacMonitor** scheme.
2. Select **My Mac** as the destination.
3. Press **⌘ + R** to build and run.

---

## 📈 Roadmap

MacMonitor is actively being developed.

### Current

* [x] macOS SwiftUI application
* [x] Menu bar application
* [x] CPU monitoring
* [x] Memory monitoring
* [x] Disk monitoring
* [x] Network monitoring
* [x] Menu bar view model

### Planned

* [ ] CPU temperature monitoring
* [ ] GPU usage monitoring
* [ ] Battery health and battery cycle information
* [ ] Fan speed monitoring
* [ ] Process monitor
* [ ] Network speed graphs
* [ ] Historical usage graphs
* [ ] Custom refresh intervals
* [ ] Launch at login
* [ ] Configurable menu bar metrics
* [ ] Notifications for high resource usage
* [ ] More advanced Liquid Glass UI
* [ ] macOS widgets

---

## 🎯 Project Goals

MacMonitor aims to provide a **simple, beautiful, and lightweight alternative to complicated system monitoring tools**.

The main goals are:

* ⚡ Fast and lightweight
* 🎨 Native macOS design
* 📊 Useful real-time statistics
* 🧩 Modular architecture
* 🔒 No unnecessary data collection
* 🖥️ Designed specifically for macOS

---

## 🤝 Contributing

Contributions are welcome!

If you have an idea, improvement, or bug fix:

1. Fork the repository.
2. Create a new branch.

```bash
git checkout -b feature/my-feature
```

3. Make your changes.
4. Commit your changes.

```bash
git commit -m "Add my feature"
```

5. Push your branch.

```bash
git push origin feature/my-feature
```

6. Open a Pull Request.

---

## 🐛 Bug Reports

Found a bug?

Please open an issue and include:

* macOS version
* Mac model
* MacMonitor version
* Steps to reproduce the issue
* Screenshots or logs if applicable

---

## 💡 Feature Requests

Have an idea for MacMonitor?

Open a feature request and describe:

* What the feature should do
* Why it would be useful
* How you think it could work

---

## 📄 License

This project is licensed under the **MIT License**.

See the `LICENSE` file for more information.

---

## 👨‍💻 Author

**Vansh Vala**

Computer Science Engineer • Full Stack Developer • SwiftUI Developer

* GitHub: [@VanshVala23](https://github.com/VanshVala23)
* Portfolio: [vansh-vala.netlify.app](https://vansh-vala.netlify.app/)

---

## ⭐ Support

If you find **MacMonitor** useful, consider giving the repository a ⭐ on GitHub!

It helps support the project and encourages further development.

---

<p align="center">
  Built with ❤️ using SwiftUI on macOS
</p>
