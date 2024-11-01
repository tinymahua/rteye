use anyhow::Result;

#[cfg(target_os = "linux")]
pub use ifstat_rs::net_stats::linux_impl::get_net_dev_stats;
#[cfg(target_os = "macos")]
pub use ifstat_rs::net_stats::macos_impl::get_net_dev_stats;
#[cfg(target_os = "windows")]
pub use ifstat_rs::net_stats::windows_impl::get_net_dev_stats;
