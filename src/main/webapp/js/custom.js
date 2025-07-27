/**
 * Custom JavaScript for International Media Academic Society
 * Author: Spring Legacy Team
 * Version: 1.0.0
 */

(function() {
    'use strict';

    // Initialize when DOM is ready
    document.addEventListener('DOMContentLoaded', function() {
        initializeApp();
    });

    function initializeApp() {
        // Initialize all components
        initializeNavigation();
        initializeAlerts();
        initializeForms();
        initializeTables();
        initializeTooltips();
        initializeModals();
        initializeSearch();
        initializeAnimations();
    }

    // Navigation enhancements
    function initializeNavigation() {
        // Active page highlighting
        const currentPath = window.location.pathname;
        const navLinks = document.querySelectorAll('.navbar-nav .nav-link');
        
        navLinks.forEach(function(link) {
            const href = link.getAttribute('href');
            if (href && currentPath.includes(href) && href !== '/') {
                link.classList.add('active');
            }
        });

        // Mobile menu auto-close
        const navbarToggler = document.querySelector('.navbar-toggler');
        const navbarCollapse = document.querySelector('.navbar-collapse');
        
        if (navbarToggler && navbarCollapse) {
            document.addEventListener('click', function(e) {
                if (!navbarToggler.contains(e.target) && !navbarCollapse.contains(e.target)) {
                    const bsCollapse = bootstrap.Collapse.getInstance(navbarCollapse);
                    if (bsCollapse && navbarCollapse.classList.contains('show')) {
                        bsCollapse.hide();
                    }
                }
            });
        }
    }

    // Alert auto-dismiss
    function initializeAlerts() {
        const alerts = document.querySelectorAll('.alert:not(.alert-permanent)');
        
        alerts.forEach(function(alert) {
            // Auto-dismiss after 5 seconds
            setTimeout(function() {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            }, 5000);
        });
    }

    // Form enhancements
    function initializeForms() {
        // Real-time validation
        const forms = document.querySelectorAll('form[novalidate]');
        
        forms.forEach(function(form) {
            form.addEventListener('submit', function(e) {
                if (!form.checkValidity()) {
                    e.preventDefault();
                    e.stopPropagation();
                    
                    // Focus on first invalid field
                    const firstInvalid = form.querySelector(':invalid');
                    if (firstInvalid) {
                        firstInvalid.focus();
                    }
                }
                form.classList.add('was-validated');
            });

            // Real-time field validation
            const inputs = form.querySelectorAll('input, textarea, select');
            inputs.forEach(function(input) {
                input.addEventListener('blur', function() {
                    validateField(input);
                });

                input.addEventListener('input', function() {
                    if (input.classList.contains('is-invalid')) {
                        validateField(input);
                    }
                });
            });
        });

        // Email validation
        const emailInputs = document.querySelectorAll('input[type="email"]');
        emailInputs.forEach(function(input) {
            input.addEventListener('blur', function() {
                validateEmail(input);
            });
        });
    }

    function validateField(field) {
        if (field.checkValidity()) {
            field.classList.remove('is-invalid');
            field.classList.add('is-valid');
        } else {
            field.classList.remove('is-valid');
            field.classList.add('is-invalid');
        }
    }

    function validateEmail(input) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (input.value && !emailRegex.test(input.value)) {
            input.setCustomValidity('Please enter a valid email address');
        } else {
            input.setCustomValidity('');
        }
        validateField(input);
    }

    // Table enhancements
    function initializeTables() {
        // Sortable columns
        const sortableHeaders = document.querySelectorAll('th[data-sortable]');
        sortableHeaders.forEach(function(header) {
            header.style.cursor = 'pointer';
            header.addEventListener('click', function() {
                sortTable(header);
            });
        });

        // Row selection
        const selectAllCheckbox = document.querySelector('input[data-select-all]');
        if (selectAllCheckbox) {
            selectAllCheckbox.addEventListener('change', function() {
                const checkboxes = document.querySelectorAll('input[data-select-row]');
                checkboxes.forEach(function(checkbox) {
                    checkbox.checked = selectAllCheckbox.checked;
                });
                updateBulkActions();
            });
        }

        const rowCheckboxes = document.querySelectorAll('input[data-select-row]');
        rowCheckboxes.forEach(function(checkbox) {
            checkbox.addEventListener('change', updateBulkActions);
        });
    }

    function sortTable(header) {
        const table = header.closest('table');
        const tbody = table.querySelector('tbody');
        const rows = Array.from(tbody.querySelectorAll('tr'));
        const columnIndex = Array.from(header.parentNode.children).indexOf(header);
        const currentOrder = header.getAttribute('data-order') || 'asc';
        const newOrder = currentOrder === 'asc' ? 'desc' : 'asc';

        rows.sort(function(a, b) {
            const aValue = a.children[columnIndex].textContent.trim();
            const bValue = b.children[columnIndex].textContent.trim();
            
            if (newOrder === 'asc') {
                return aValue.localeCompare(bValue, undefined, { numeric: true });
            } else {
                return bValue.localeCompare(aValue, undefined, { numeric: true });
            }
        });

        // Clear existing rows and add sorted rows
        tbody.innerHTML = '';
        rows.forEach(function(row) {
            tbody.appendChild(row);
        });

        // Update header indicators
        const allHeaders = table.querySelectorAll('th[data-sortable]');
        allHeaders.forEach(function(h) {
            h.removeAttribute('data-order');
            h.innerHTML = h.innerHTML.replace(/ ↑| ↓/g, '');
        });

        header.setAttribute('data-order', newOrder);
        header.innerHTML += newOrder === 'asc' ? ' ↑' : ' ↓';
    }

    function updateBulkActions() {
        const selectedCheckboxes = document.querySelectorAll('input[data-select-row]:checked');
        const bulkActionsContainer = document.querySelector('.bulk-actions');
        
        if (bulkActionsContainer) {
            if (selectedCheckboxes.length > 0) {
                bulkActionsContainer.style.display = 'block';
                const selectedCount = document.querySelector('.selected-count');
                if (selectedCount) {
                    selectedCount.textContent = selectedCheckboxes.length;
                }
            } else {
                bulkActionsContainer.style.display = 'none';
            }
        }
    }

    // Initialize tooltips
    function initializeTooltips() {
        const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
        const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));
    }

    // Modal enhancements
    function initializeModals() {
        const modals = document.querySelectorAll('.modal');
        
        modals.forEach(function(modal) {
            modal.addEventListener('shown.bs.modal', function() {
                const autofocusElement = modal.querySelector('[autofocus]');
                if (autofocusElement) {
                    autofocusElement.focus();
                }
            });
        });

        // Confirmation modals
        const confirmButtons = document.querySelectorAll('[data-confirm]');
        confirmButtons.forEach(function(button) {
            button.addEventListener('click', function(e) {
                e.preventDefault();
                const message = button.getAttribute('data-confirm');
                const form = button.closest('form');
                
                if (confirm(message)) {
                    if (form) {
                        form.submit();
                    } else {
                        window.location.href = button.href;
                    }
                }
            });
        });
    }

    // Search enhancements
    function initializeSearch() {
        const searchInputs = document.querySelectorAll('input[type="search"], input[name="search"], input[name="keyword"]');
        
        searchInputs.forEach(function(input) {
            let searchTimeout;
            
            input.addEventListener('input', function() {
                clearTimeout(searchTimeout);
                
                if (input.getAttribute('data-live-search') === 'true') {
                    searchTimeout = setTimeout(function() {
                        performLiveSearch(input);
                    }, 300);
                }
            });

            // Clear search
            const clearButton = input.parentNode.querySelector('.clear-search');
            if (clearButton) {
                clearButton.addEventListener('click', function() {
                    input.value = '';
                    input.form.submit();
                });
            }
        });
    }

    function performLiveSearch(input) {
        const form = input.closest('form');
        if (form && input.value.length >= 2) {
            form.submit();
        }
    }

    // Animations
    function initializeAnimations() {
        // Fade in elements on scroll
        const observer = new IntersectionObserver(function(entries) {
            entries.forEach(function(entry) {
                if (entry.isIntersecting) {
                    entry.target.classList.add('fade-in');
                }
            });
        });

        const animatedElements = document.querySelectorAll('.animate-on-scroll');
        animatedElements.forEach(function(element) {
            observer.observe(element);
        });

        // Smooth scrolling for anchor links
        const anchorLinks = document.querySelectorAll('a[href^="#"]');
        anchorLinks.forEach(function(link) {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                const targetId = link.getAttribute('href').substring(1);
                const targetElement = document.getElementById(targetId);
                
                if (targetElement) {
                    targetElement.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    }

    // Utility functions
    window.StudentManagement = {
        // Export selected students
        exportSelected: function() {
            const selected = document.querySelectorAll('input[data-select-row]:checked');
            const ids = Array.from(selected).map(cb => cb.value);
            
            if (ids.length === 0) {
                alert('Please select students to export');
                return;
            }

            // Create and download CSV
            const csvContent = this.generateCSV(ids);
            this.downloadCSV(csvContent, 'students-export.csv');
        },

        generateCSV: function(ids) {
            let csv = 'ID,Name,Email,Created,Updated\n';
            
            ids.forEach(function(id) {
                const row = document.querySelector(`tr[data-id="${id}"]`);
                if (row) {
                    const cells = row.querySelectorAll('td');
                    const csvRow = Array.from(cells).slice(0, 5).map(cell => 
                        `"${cell.textContent.trim()}"`
                    ).join(',');
                    csv += csvRow + '\n';
                }
            });
            
            return csv;
        },

        downloadCSV: function(content, filename) {
            const blob = new Blob([content], { type: 'text/csv;charset=utf-8;' });
            const link = document.createElement('a');
            
            if (link.download !== undefined) {
                const url = URL.createObjectURL(blob);
                link.setAttribute('href', url);
                link.setAttribute('download', filename);
                link.style.visibility = 'hidden';
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            }
        }
    };

    // API utilities
    window.API = {
        baseUrl: window.location.origin,
        
        request: function(url, options = {}) {
            const defaultOptions = {
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                }
            };
            
            const finalOptions = Object.assign({}, defaultOptions, options);
            
            return fetch(url, finalOptions)
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`HTTP error! status: ${response.status}`);
                    }
                    return response.json();
                })
                .catch(error => {
                    console.error('API request failed:', error);
                    throw error;
                });
        },

        get: function(endpoint) {
            return this.request(`${this.baseUrl}/api${endpoint}`);
        },

        post: function(endpoint, data) {
            return this.request(`${this.baseUrl}/api${endpoint}`, {
                method: 'POST',
                body: JSON.stringify(data)
            });
        },

        put: function(endpoint, data) {
            return this.request(`${this.baseUrl}/api${endpoint}`, {
                method: 'PUT',
                body: JSON.stringify(data)
            });
        },

        delete: function(endpoint) {
            return this.request(`${this.baseUrl}/api${endpoint}`, {
                method: 'DELETE'
            });
        }
    };

    // Performance monitoring
    window.Performance = {
        markStart: function(name) {
            if (performance && performance.mark) {
                performance.mark(`${name}-start`);
            }
        },

        markEnd: function(name) {
            if (performance && performance.mark && performance.measure) {
                performance.mark(`${name}-end`);
                performance.measure(name, `${name}-start`, `${name}-end`);
                
                const measure = performance.getEntriesByName(name)[0];
                console.log(`${name}: ${measure.duration.toFixed(2)}ms`);
            }
        }
    };

    // Error handling
    window.addEventListener('error', function(e) {
        console.error('JavaScript error:', e.error);
        // Could send to logging service here
    });

    window.addEventListener('unhandledrejection', function(e) {
        console.error('Unhandled promise rejection:', e.reason);
        // Could send to logging service here
    });

})();